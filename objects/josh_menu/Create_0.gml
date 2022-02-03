// GUI setup
depth = -1000;

var windows_width = window_get_width();
var windows_height = window_get_height();
display_set_gui_size(windows_width,windows_height);

// Functions
function draw_set_falign(halign,valign)
{
	draw_set_halign(halign);
	draw_set_valign(valign);
}

// Macros
#macro GUI_X device_mouse_x_to_gui(0)
#macro GUI_Y device_mouse_y_to_gui(0)

// Variables
mouse_xx = mouse_x;
mouse_yy = mouse_y;

drawing = false;

// Menu options
options = ["Inspect", "Delete", "Create", "Copy","Paste", "Variable", "Back"];
length = array_length(options);

showing_error = false;
errors = ["No object selected", "Selected object has no variables"];
error = 0;

cursor = 0;

instance = noone;
copied = noone;
object_copied = false;

inspecting = false;
creating = false;

merge = 0;

objects = [];
var i = 0;
while (object_exists(i)) 
{
    array_push(objects,i);
    i++;
}

max_width = 0;
for (var i = 0; i < array_length(objects); i++)
{
	if (max_width < string_width(object_get_name(objects[i])))
	{
		max_width = string_width(object_get_name(objects[i]));	
	}
}

max_objects = 10;
out_max = array_length(objects) - max_objects;
if (out_max < 0)
{
	out_max = array_length(objects);	
}

wheel = 0;

o_cursor = 0;
selected_cursor = 0;

drawing_create = false;

showing_vars = false;
vars = [];
var_cursor = 0;
drawing_typeof = false;
last_type = 0;

max_vars = 6;
out_var = 0;
var_wheel = 0;

// Settings
default_sprite = placeholder;
font = josh_menu_font;
box_color = c_black;
text_color = c_white;
text_selected_color = c_green;
text_selected_box_color = c_gray;