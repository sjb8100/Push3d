struct VS_in {
	float4 Position : POSITION0; // (x,y,z,w)
	float3 Normal   : NORMAL0;   // (x,y,z)
	float2 TexCoord : TEXCOORD0; // (u,v)
	float4 TangentW : TEXCOORD1; // (tangent.xyz,bitangentSign)
};

struct VS_out {
	float4 Position : SV_POSITION;
	float2 TexCoord : TEXCOORD0;
};

void main(in VS_in IN, out VS_out OUT) {
	OUT.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], IN.Position);
	OUT.Position.z = OUT.Position.z * 0.5 + 0.5;
	OUT.TexCoord = IN.TexCoord;
}