// Setup
depth = -1000;

// Macros
#macro GUI_X device_mouse_x_to_gui(0)
#macro GUI_Y device_mouse_y_to_gui(0)

// Variables
mouse_xx = mouse_x;
mouse_yy = mouse_y;

drawing = false;

// Menu options
template =  new Option("Template", 
			function()
			{
				show_message("Hello world!");		
			}
		);

options = [
	new Option("Inspect",
		function()
		{
			inspecting = true;
			showing_vars = false;
		}
	),
	new Option("Delete",
		function()
		{
			if (instance != noone) then instance_destroy(instance);
			else 
			{
				error = 0;
				showing_error = true;
			}
		}
	),
	new Option("Create",
		function()
		{
			creating = true;
		}
	),
	new Option("Copy",
		function()
		{
			if (instance != noone)
			{
				copied = instance;
				object_copied = true;
			}
			else
			{
				error = 0;
				showing_error = true;	
			}
		}
	),
	new Option("Paste",
		function()
		{
			if (object_copied != false)
			{
				var lay = layer_create(depth - 1);
				instance_create_layer(mouse_x,mouse_y, lay, copied.object_index);
			}
			else
			{
				error = 2;
				showing_error = true;	
			}
		}
	),
	new Option("Variable",
		function()
		{
			if (instance != noone)
			{
				var variables = variable_instance_get_names(instance);
				
				if (array_length(variables) > 0)
				{
					inspecting = false;
					showing_vars = true;
				}
				else
				{
					inserted = false;
				}
			}
			else
			{
				error = 0;
				showing_error = true;		
			}
		}
	),
	new Option("Back",
		function()
		{
			instance = noone;
			object_copied = false;
			drawing = false;
			creating = false;
			showing_vars = false;
			inspecting = false;
		}
	),
	
];
length = array_length(options);

showing_error = false;
errors = ["No object selected", "Selected object has no variables", "No object copied"];
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
default_vars = 
[
	"direction",
	"gravity",
	"hspeed",
	"vspeed",
	"speed",
	"x",
	"y",
	"sprite_index",
	"image_alpha",
	"image_angle",
	"image_blend",
	"image_index",
	"image_number",
	"image_speed",
	"image_xscale",
	"image_yscale",
];
vars = [];
inserted = false;
var_cursor = 0;
drawing_var = false;
drawing_types = false;
types = [1, true, "Hello world!"];
writing_type = false;
new_var = "";
last_var = 0;
type_cursor = 0;
last_type = 0;

max_vars = 6;
out_var = 0;
var_wheel = 0;

// Settings
default_sprite = SPRITE;
font = FONT;
box_color = MENU_COLOR;
text_color = TEXT_COLOR;
text_selected_color = SELECTED_TEXT_COLOR;
text_selected_box_color = SELECTED_MENU_COLOR;

// Full debug
full_debug = false;
old_number = instance_count;