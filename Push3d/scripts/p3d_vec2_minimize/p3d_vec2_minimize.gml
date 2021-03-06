/// @func p3d_vec2_minimize(v1, v2)
/// @desc Gets a vector that is made up of the smallest components of the
///       vectors `v1`, `v2` and stores it into `v1`.
/// @param {array} v1 The first vector.
/// @param {array} v2 The second vector.
/// @example
/// This would make the vector `_v1` equal to `[1, 3]`.
/// ```
/// var _v1 = [1, 4];
/// var _v2 = [2, 3];
/// p3d_vec2_minimize(_v1, _v2);
/// ```
argument0[@ 0] = min(argument0[0], argument1[0]);
argument0[@ 1] = min(argument0[1], argument1[1]);