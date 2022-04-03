/// @desc
draw_set_font(font);
___draw_set_falign_(fa_left,fa_middle);

if (mouse_check_button_pressed(mb_right))
{
	var inst = instance_position(mouse_x,mouse_y, all);
	
	if (inst != noone)
	{
		instance = inst;
		showing_vars = false;
		vars = variable_instance_get_names(instance);
		vars = ___array_merge_(vars, default_vars);
	}
	
	drawing = true;
	mouse_xx = GUI_X;
	mouse_yy = GUI_Y;
}

var	start_x = mouse_xx;
var	start_y = mouse_yy;
var	width = 175;
var	height = ceil(length / 2) * 100;
var	end_x = start_x + width;
var	end_y = start_y + height;

var g_width = display_get_gui_width();
var g_height = display_get_gui_height();

if (drawing == true)
{
	draw_set_color(box_color);
	draw_set_alpha(0.7);
	draw_rectangle(mouse_xx,mouse_yy, end_x, end_y, false);
	
	draw_set_alpha(1);
	
	for (var i = 0; i < length; i++)
	{
		var cell_height = height / length;
		var text_start_y = cell_height / 2;
		var color = text_color;
		
		draw_set_color(box_color);
		draw_line(mouse_xx,mouse_yy + (cell_height * i), end_x,mouse_yy + (cell_height * i));	
		draw_set_color(color);
		
		if (i == cursor) then color = text_selected_color;
		else color = text_color;
		
		draw_set_color(color);
		
		draw_text(mouse_xx + 10,mouse_yy + text_start_y + (cell_height * i), options[i].name);
	}
	// Mouse
	if (GUI_Y < end_y && GUI_Y > start_y && GUI_X < end_x && GUI_X > start_x)
	{
		cursor = abs(((end_y - GUI_Y) div cell_height) - length + 1);
		
		draw_set_color(text_selected_box_color)
		draw_set_alpha(0.1);
		draw_rectangle(mouse_xx,mouse_yy + (cell_height * cursor), end_x,mouse_yy + (cell_height * (cursor + 1)), false);
		draw_set_color(text_color);
		draw_set_alpha(1);
			
		if (mouse_check_button_pressed(mb_left))
		{				
			options[cursor].func();	
		}
	}
	else 
	{
		if (mouse_check_button_pressed(mb_left))
		{
			drawing = false;
		}
		cursor = -1;
	}
}

// Options with boolean
if (inspecting == true)
{
	draw_set_color(box_color);
	with (instance)
	{
		draw_set_alpha(0.7);
		draw_rectangle(g_width - 325,0, g_width, 270, false);
		draw_set_alpha(1);
		draw_rectangle(g_width - 325,0, g_width, 270, true);
	}
	draw_set_color(text_color);
	with (instance)
	{
		draw_set_valign(fa_top);
		draw_text(g_width - 300,15, "ID: " + string(id) + 
			"\nObject: " + string(object_get_name(object_index)) +
			"\nX: " + string(x) + "\nY: " + string(y) +
			"\nWidth: " + string(sprite_width) + "\nHeight: " + string(sprite_height) +
			"\nAlpha: " + string(image_alpha) +
			"\nAngle: " + string(image_angle) + 
			"\nScale x: " + string(image_xscale) + "\nScale y: " + string(image_yscale));
	}
	
	var col = merge_color(text_color, c_red, merge);
	var exit_text = "x";
	var text_width = string_width(exit_text);
	
	draw_set_color(col);
	draw_text(g_width - 25, 5, exit_text);
	if (GUI_X > g_width - 35 && GUI_X < g_width - (text_width - 10) && GUI_Y > 5 && GUI_Y < 35) 
	{
		if (merge < 1) then merge += 0.05;
		if (mouse_check_button_pressed(mb_left))
		{
			inspecting = false;
		}
	}
	else
	{
		if (merge > 0) then merge -= 0.05;	
	}
}
if (creating == true)
{
	if (array_length(objects) >= max_objects)
	{
		var len_ = array_length(objects);
		var drawn = len_ - out_max;
		var gui_width = display_get_gui_width();
		var gui_height = display_get_gui_height();
		var width_ = max_width + max_width/2;
		var height_ = drawn * 50;
		var x_start = (gui_width/2) - (width_/2);
		var y_start = (gui_height/2) - (height_/2);
		var x_end = x_start + width_;
		var y_end = y_start + height_;
		var cell_height = height_ / drawn;
		var height_difference = (cell_height * wheel);
	
		draw_set_alpha(0.7);
		draw_set_color(box_color);
		draw_rectangle(x_start,y_start,x_end,y_end, false);
		draw_set_alpha(1);
		draw_rectangle(x_start,y_start,x_end,y_end, true);
	
		for (var i = wheel; i < len_ - (out_max - wheel); i++)
		{
			draw_set_color(box_color);
			draw_line(x_start,y_start + (cell_height * i) - height_difference, x_end,y_start + (cell_height * i) - height_difference);
		
			if (i == o_cursor) then color = text_selected_color;
			else color = text_color;
			draw_set_color(color);
			draw_text(x_start + 10,(y_start + cell_height/2) + ((cell_height * i) - height_difference), object_get_name(objects[i]));
		}
		// Mouse
		if (GUI_Y < y_end && GUI_Y > y_start && GUI_X < x_end && GUI_X > x_start)
		{
			o_cursor = abs(((y_end - GUI_Y) div cell_height) - drawn) + (wheel - 1);	
			draw_set_color(text_selected_box_color);
			draw_set_alpha(0.1);
			draw_rectangle(x_start,y_start + (cell_height * o_cursor) - cell_height * wheel, x_end,y_start + (cell_height * (o_cursor + 1)) - cell_height * wheel, false);
		
			if (mouse_check_button_pressed(mb_left))
			{
				drawing_create = true;
				selected_cursor = o_cursor;
			}
		}
		else 
		{
			o_cursor = -1;
		}
	
		if (drawing_create == true)
		{
			var obj = objects[selected_cursor];
			var selected = object_get_sprite(obj);
			if (sprite_exists(selected))
			{
				selected = object_get_sprite(obj);
			}
			else selected = default_sprite;
		
			draw_set_alpha(0.3);
			draw_sprite(selected, 0, GUI_X,GUI_Y);
			if (o_cursor == -1 && mouse_check_button_pressed(mb_left))
			{
				var lay = layer_create(depth - 1);
				instance_create_layer(mouse_x,mouse_y, lay,obj);
				
				selected_cursor = 0;
				drawing_create = false;
			}
			draw_set_alpha(1);
		}
	}
	else 
	{
		var len_ = array_length(objects);
		var cell_height = 50;
		var height = len_ * cell_height;
		var width = max_width + max_width/2;
		var gui_width = display_get_gui_width();
		var gui_height = display_get_gui_height();
		var x_start = (gui_width/2) - (width/2);
		var y_start = (gui_height/2) - (height/2);
		var x_end = x_start + width;
		var y_end = y_start + height;
					
		draw_set_alpha(0.7);
		draw_set_color(box_color);
		
		draw_rectangle(x_start,y_start, x_end,y_end, false);
			
		for (var i = 0; i < len_; i++)
		{
			var cells = cell_height * i;
			
			draw_set_alpha(1);
			draw_set_color(box_color);
			
			draw_line(x_start,y_start + cells, x_end,y_start + cells);
			
			if (i == o_cursor) then color = text_selected_color;
			else color = text_color;
			
			draw_set_color(color);
			___draw_set_falign_(fa_left,fa_middle);
			
			draw_text(x_start + 10, (y_start + cell_height/2) + cells, object_get_name(objects[i]));
		}
		
		// Mouse
		if (GUI_Y < y_end && GUI_Y > y_start && GUI_X < x_end && GUI_X > x_start)
		{
			o_cursor = abs(((y_end - GUI_Y) div cell_height) - len_ + 1);
			
			draw_set_color(text_selected_box_color);
			draw_set_alpha(0.1);
			draw_rectangle(x_start,y_start + (cell_height * o_cursor), x_end,y_start + (cell_height * (o_cursor + 1)), false);
		
			if (mouse_check_button_pressed(mb_left))
			{
				drawing_create = true;
				selected_cursor = o_cursor;
			}
		}
		else 
		{
			o_cursor = -1;
		}
		
		if (drawing_create == true)
		{
			var obj = objects[selected_cursor];
			var selected = object_get_sprite(obj);
			if (sprite_exists(selected))
			{
				selected = object_get_sprite(obj);
			}
			else selected = default_sprite;
		
			draw_set_alpha(0.3);
			draw_sprite(selected, 0, GUI_X,GUI_Y);
			if (o_cursor == -1 && mouse_check_button_pressed(mb_left))
			{
				var lay = layer_create(depth - 1);
				instance_create_layer(mouse_x,mouse_y, lay,obj);
				
				selected_cursor = 0;
				drawing_create = false;
			}
			draw_set_alpha(1);
		}
	}
}

if (showing_vars == true)
{
	out_var = array_length(vars) - max_vars;

	var start_x = g_width - 325;
	var start_y = 0;
	var end_x = g_width;
	var cell_height = 50;
	var end_y = cell_height * max_vars;
	var width = start_x - end_x;
	var height = start_y - end_y;
	var lines = abs(height / cell_height);
		
	draw_set_color(box_color);
	draw_set_alpha(0.7);
	
	draw_rectangle(start_x,start_y, end_x,end_y, false);
		
	for (var i = 1; i <= lines; i++)
	{
		var offset_y = cell_height * i;
			
		draw_set_alpha(1);
		
		draw_line(start_x,start_y + offset_y, end_x, start_y + offset_y);
	}
		
	draw_set_color(text_color);
		
	for (var i = var_wheel; i < var_wheel + max_vars; i++)
	{
		var text = variable_instance_get(instance, vars[i]);
			
		if (i == var_cursor) then color = text_selected_color;
		else color = text_color;
			
		draw_set_color(color);
			
		draw_text(start_x + 10,start_y + cell_height/2 + (cell_height * i) - cell_height * var_wheel, vars[i] + ": " + string(text));
	}
		
	if (GUI_Y < end_y && GUI_Y > start_y && GUI_X < end_x && GUI_X > start_x)
	{
		var_cursor = abs(((end_y - GUI_Y) div cell_height) - out_max) + var_wheel;
			
		draw_set_color(text_selected_box_color);
		draw_set_alpha(0.1);
			
		draw_rectangle(start_x,start_y + (cell_height * (var_cursor - var_wheel)), end_x,start_y + (cell_height * ((var_cursor + 1 - var_wheel))), false);
			
		if (mouse_check_button_pressed(mb_left)) 
		{
			drawing_var = true;
			last_type = typeof(variable_instance_get(instance, vars[var_cursor]));
			last_var = vars[var_cursor];
		}
	}
	else 
	{
		var_cursor = -1;
	}
}
// Creating error
if (showing_error == true)
{
	var message_width = string_width(errors[error]) * 1.1;
	
	___draw_message_(g_width/2 - message_width/2,g_height/2 - 50, message_width,100, errors[error], 0);	
	instance = noone;
	object_copied = false;
	drawing = false;
	creating = false;
	showing_vars = false;
}
// Drawing type of variable
if (drawing_var == true)
{	
	var msg_width = 150;
	
	___draw_variable_(g_width/2 - msg_width/2,g_height/2 - 50, msg_width,120, ___capitalize_(string(last_type)));
	creating = false;
}

// Full debug mode
if (full_debug == true)
{
	with (all)	
	{
		if (position_meeting(mouse_x,mouse_y, object_index))
		{
			if (mouse_check_button_pressed(mb_any)) 
			{
				___draw_text_fade_(g_width/2,g_height/2, string(id) + " Was clicked");
			}
		}
	}
	if (instance_count > old_number + instance_number(josh_menu_text))
	{
		old_number = instance_count - 1;
		___draw_text_fade_(g_width/2,g_height/2, "An instance was created");
	}
	if (instance_count < old_number - instance_number(josh_menu_text))
	{
		old_number = instance_count;
		___draw_text_fade_(g_width/2,g_height/2, "An instances was destroyed");
	}
}

