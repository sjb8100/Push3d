/// @desc Camera control
var _mouseX = window_mouse_get_x();
var _mouseY = window_mouse_get_y();

if (mouse_check_button(mb_right)) {
	direction += mouseXLast - _mouseX;
	pitch = clamp(pitch + mouseYLast - _mouseY, -89, 89);
}

mouseXLast = _mouseX;
mouseYLast = _mouseY;

var _speed = 1;
if (keyboard_check(vk_shift)) {
	_speed *= 2;
}

if (keyboard_check(ord("W"))) {
	x += dcos(direction) * _speed;
	y -= dsin(direction) * _speed;
} else if (keyboard_check(ord("S"))) {
	x -= dcos(direction) * _speed;
	y += dsin(direction) * _speed;
}

if (keyboard_check(ord("A"))) {
	x += dcos(direction + 90) * _speed;
	y -= dsin(direction + 90) * _speed;
} else if (keyboard_check(ord("D"))) {
	x += dcos(direction - 90) * _speed;
	y -= dsin(direction - 90) * _speed;
}

z += (keyboard_check(ord("E")) - keyboard_check(ord("Q"))) * _speed;