/// @func p3d_vec3_maximize(v1, v2)
/// @desc Gets a vector that is made up of the largest components of the
///       vectors `v1`, `v2` and stores it into `v1`.
/// @param {array} v1 The first vector.
/// @param {array} v2 The second vector.
/// @example
/// This would make the vector `_v1` equal to `[2, 4, 6]`.
/// ```
/// var _v1 = [1, 4, 5];
/// var _v2 = [2, 3, 6];
/// p3d_vec3_maximize(_v1, _v2);
/// ```
argument0[@ 0] = max(argument0[0], argument1[0]);
argument0[@ 1] = max(argument0[1], argument1[1]);
argument0[@ 2] = max(argument0[2], argument1[2]);