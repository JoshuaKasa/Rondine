/// @desc
if (array_length(objects) > max_objects)
{
	if (mouse_wheel_down() && wheel < out_max) then wheel++;
	else if (mouse_wheel_up() && wheel > 0) then wheel--;
}
if (array_length(vars) > max_vars)
{
	if (mouse_wheel_down() && var_wheel < out_var) then var_wheel++;
	else if (mouse_wheel_up() && var_wheel > 0) then var_wheel--;
}