/// @func p3d_vec2_lengthsqr(v)
/// @desc Gets squared length of the vector.
/// @param {array} v The vector.
/// @param {real} The vector's squared length.
gml_pragma("forceinline");
return (argument0[0] * argument0[0]
	+ argument0[1] * argument0[1]);