/// @desc Init
z         = 0;
radius    = 256;
color     = make_color_hsv(random(255), 255, 255);
intensity = 1;
cubemap   = p3d_cubemap_create(256);
shadowmap = noone;