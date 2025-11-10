if (!instance_exists(target)) exit;

cam_w = camera_get_view_width(cam);
cam_h = camera_get_view_height(cam);

var _tx = target.x;
var _ty = target.y;

var nx = clamp(_tx - cam_w * 0.5, 0, room_width  - cam_w);
var ny = clamp(_ty - cam_h * 0.5, 0, room_height - cam_h);

camera_set_view_pos(cam, nx, ny);