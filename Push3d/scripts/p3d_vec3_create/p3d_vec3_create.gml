/// @func p3d_vec3_create(x[, y, z])
/// @desc Creates a new vector with given components. If only the first value
///       is supplied, then it is used for every component.
/// @param {real} x The first vector component.
/// @param {real} y The second vector component.
/// @param {real} z The third vector component.
/// @return {array} The created vector.
/// @note One could also just write `[x, y, z]`, which would give the same
///       result.
gml_pragma("forceinline");
if (argument_count == 1)
{
	return [argument[0], argument[0], argument[0]];
}
if (argument_count == 3)
{
	return [argument[0], argument[1], argument[2]];
}
p3d_assert(false, "Trying to construct a 3D vector with " + string(argument_count)
	+ " components!");