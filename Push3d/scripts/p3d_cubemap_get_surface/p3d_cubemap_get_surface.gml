/// @func p3d_cubemap_get_surface(cubemap, side)
/// @desc Gets a surface for given cubemap side. If the surface is corrupted,
///       then a new one is created.
/// @param {array} cubemap The cubemap.
/// @param {real}  side    The cubemap side.
/// @return {real} The surface.
var _size   = argument0[P3D_CUBEMAP_SIZE];
var _surOld = argument0[argument1];
var _sur    = p3d_surface_check(_surOld, _size, _size);
if (_sur != _surOld)
{
	argument0[@ argument1] = _sur;
}
return _sur;