#pragma include("Common.fsh")
float3 xEncodeDepth(float d) {
	float3 enc = float3(1.0, 255.0, 65025.0) * d;
	enc = frac(enc);
	enc -= float3(enc.y, enc.z, enc.z)
		* float3(1.0 / 255.0, 1.0 / 255.0, 1.0 / 255.0);
	return enc;
}

float xDecodeDepth(float3 c) {
	return dot(c, float3(1.0, 1.0 / 255.0, 1.0 / 65025.0));
}

float3 xProject(float2 tanAspect, float2 texCoord, float depth) {
	// tanAspect = (tanFovY * (screenWidth / screenHeight), -tanFovY), where:
	//   tanFovY = dtan(fov * 0.5)
	return float3(tanAspect * (texCoord * 2.0 - 1.0) * depth, depth);
}
// include("Common.fsh")

Texture2D texNormal    : register(t1);
Texture2D texDepth     : register(t2);
Texture2D texShadowMap : register(t3);

uniform float4x4 u_mInverse;
uniform float4x4 u_mShadowMap;
uniform float    u_fShadowMapArea;
uniform float    u_fClipFar;
uniform float2   u_fTanAspect;
uniform float3   u_fLightDir;
uniform float4   u_fLightCol; // (r,g,b,intensity)

struct VS_out {
	float4 Position : SV_POSITION;
	float2 TexCoord : TEXCOORD0;
};

struct PS_out {
	float4 Target0 : SV_TARGET0;
};

void main(in VS_out IN, out PS_out OUT) {
	float4 base = gm_BaseTextureObject.Sample(gm_BaseTexture, IN.TexCoord);
	if (base.a < 1.0) {
		discard;
	}

	float shadow = 0.0;
	float3 N = normalize(texNormal.Sample(gm_BaseTexture, IN.TexCoord).xyz * 2.0 - 1.0);
	float3 L = -normalize(u_fLightDir);
	float NdotL = saturate(dot(N, L));
	
	if (NdotL > 0.0) {
		float depth = xDecodeDepth(texDepth.Sample(gm_BaseTexture, IN.TexCoord).xyz) * u_fClipFar;
		float3 posView = xProject(u_fTanAspect, IN.TexCoord, depth);
		float3 posWorld = mul(u_mInverse, float4(posView, 1.0)).xyz;

		float3 posShadowMap = mul(u_mShadowMap, float4(posWorld, 1.0)).xyz;
		posShadowMap.z = posShadowMap.z * 0.5 + 0.5;
		float2 texCoordShadowMap = float2(posShadowMap.xy * 0.5 + 0.5);

		if (texCoordShadowMap.x >= 0.0
			&& texCoordShadowMap.y >= 0.0
			&& texCoordShadowMap.x <= 1.0
			&& texCoordShadowMap.y <= 1.0) {
			texCoordShadowMap.y = 1.0 - texCoordShadowMap.y;
			float3 shadowMap = texShadowMap.Sample(gm_BaseTexture, texCoordShadowMap).xyz;
			shadow = xDecodeDepth(shadowMap) < posShadowMap.z ? 1.0 : 0.0;

			float lerpRegion = 4.0;
			float shadowLerp =
				clamp((length(posView) - u_fShadowMapArea * 0.5 + lerpRegion) / lerpRegion, 0.0, 1.0);
			shadow = lerp(shadow, 0.0, shadowLerp);
		}
	}

	float4 lightCol;
	lightCol.rgb = u_fLightCol.rgb * u_fLightCol.a * NdotL * (1.0 - shadow);
	lightCol.a = 1.0;

	OUT.Target0 = base * lightCol;
}