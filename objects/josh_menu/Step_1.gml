/// @desc
var windows_width = window_get_width();
var windows_height = window_get_height();
display_set_gui_size(windows_width,windows_height);

if (array_length(objects) > max_objects)
{
	if (mouse_wheel_down() && wheel < out_max) then wheel++;
	else if (mouse_wheel_up() && wheel > 0) then wheel--;
}

if (mouse_wheel_down() && var_wheel < out_var) then var_wheel++;
else if (mouse_wheel_up() && var_wheel > 0) then var_wheel--;

if (instance_number(josh_menu) > 1) then instance_destroy();

with (instance)
{
	image_index = floor(image_index);
	
	if (image_number == 1) then image_speed = 0;
}
