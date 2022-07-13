function ___draw_hitbox_()
{
	draw_rectangle(bbox_left,bbox_top, bbox_right,bbox_bottom, true);
}

function ___draw_set_falign_(halign,valign)
{
	draw_set_halign(halign);
	draw_set_valign(valign);
}

function ___rectangle_hover_(start_x,start_y, end_x,end_y)
{
	var mx = GUI_X;
	var my = GUI_Y;
	
	return point_in_rectangle(mx,my, start_x,start_y, end_x,end_y);
}

function ___oscillate_(from, to, duration)
{
	var dis = (to - from) / 2;
	duration /= 120;
	 
	return from + dis + sin(((current_time / 1000) + to * TAU)/duration) * dis;
}

function ___blink_(from, to, duration)
{
	return round(___oscillate_(from, to, duration));
}

function ___draw_message_(x_,y_, width,height, message_, to_change)
{
	draw_set_color(box_color);
	draw_set_alpha(1);
	
	draw_rectangle(x_,y_, x_ + width,y_ + height, true);
	draw_line(x_,y_ + height - 30, x_ + width,y_ + height - 30);
	
	draw_set_alpha(0.7);
	
	draw_rectangle(x_,y_, x_ + width,y_ + height, false);
	
	draw_set_color(text_color);
	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	var center_x = x_ + width/2;
	var center_y = y_ + height/2.5;
	var middle_x = x_ + width/2;
	var middle_y = y_ + height - 30/2;
	
	if (___rectangle_hover_(x_,y_ + height - 30, x_ + width,y_ + height)) 
	{
		draw_set_alpha(0.1);
		draw_set_color(text_selected_box_color);
		draw_rectangle(x_,y_ + height - 30, x_ + width,y_ + height, false);		
		draw_set_color(text_selected_color);
		
		if (mouse_check_button_pressed(mb_left))
		{
			if (to_change == 0)
			{
				showing_error = false;
			}
			else if (to_change == 1)
			{
				drawing_var = false;
			}
			else
			{
				// Other messages boolean here	
			}
		}
	}
	
	draw_set_alpha(1);
	draw_text(middle_x,middle_y, "Ok");
	draw_set_color(text_color);
	draw_text(center_x,center_y, message_);
}

function ___draw_variable_(x_,y_, width,height, text)
{
	var cells = array_length(types);
	var cell_height = (height - (height - 30)) * 1.2;
	var total_height = cell_height * cells;
	var box_height = 30 * 1.2;
	var confirm_height = box_height + 30 * 1.2;
	
	___draw_set_falign_(fa_middle,fa_center);
	draw_set_alpha(0.7);
	
	draw_set_color(box_color);
	draw_rectangle(x_,y_, x_ + width,y_ + height, false);
	draw_rectangle(x_,y_ - box_height, x_ + width,y_, false);
	draw_rectangle(x_,y_ - confirm_height, x_ + width,y_ - box_height, false);
	
	draw_set_alpha(1);
	
	draw_set_color(box_color);
	draw_rectangle(x_,y_ - box_height, x_ + width,y_ - 1, true);
	draw_rectangle(x_,y_, x_ + width,y_ + height, true);
	draw_line(x_,y_ + height - cell_height, x_ + width,y_ + height - cell_height);
	draw_rectangle(x_,y_ - confirm_height, x_ + width,y_ - box_height - 1, true);
	
	draw_set_color(text_color);
	
	if (___rectangle_hover_(x_,y_ - box_height, x_ + width,y_ - 1))
	{
		if (mouse_check_button_pressed(mb_left))
		{
			keyboard_string = new_var;
			writing_type = !writing_type;	
		}
	}
	else if (!___rectangle_hover_(x_,y_ - box_height, x_ + width,y_ - 1))
	{
		if (mouse_check_button_pressed(mb_left))
		{
			writing_type = false;	
		}
	}
	
	if (___rectangle_hover_(x_,y_ + height - cell_height, x_ + width,y_ + height))
	{
		draw_set_alpha(0.1);
		draw_set_color(text_selected_box_color);
		draw_rectangle(x_,y_ + height - cell_height, x_ + width,y_ + height, false);		
		draw_set_color(text_selected_color);	
		
		if (mouse_check_button_pressed(mb_left))
		{
			drawing_types = !drawing_types;	
		}
	}
	
	draw_set_alpha(1);
	draw_text(x_ + width/2,y_ + height - cell_height/2, "Type");
	draw_set_color(text_color);
	draw_text(x_ + width/2,y_ + height/2 - cell_height/2, text);
	
	draw_set_color(box_color);
	
	if (drawing_types == true)
	{	
		for (var i = 1; i <= cells; i++)
		{
			draw_line(x_,y_ + height + cell_height * i, x_ + width,y_ + height + cell_height * i);
		}
		
		draw_set_alpha(0.7);
		draw_set_color(box_color);
		
		draw_rectangle(x_,y_ + height + 1, x_ + width,y_ + height + total_height, false);
		
		if (___rectangle_hover_(x_,y_ + height, x_ + width,y_ + height + total_height))
		{
			draw_set_color(text_selected_box_color);
			draw_set_alpha(0.1);
			
			type_cursor = abs((y_ + height - GUI_Y) div cell_height);
			
			draw_rectangle(x_,y_ + height + (type_cursor * cell_height), x_ + width,y_ + height + ((type_cursor + 1) * cell_height), false);
			
			if (mouse_check_button_pressed(mb_left))
			{
				last_type = typeof(types[type_cursor]);
				drawing_types = false;
			}
		}
		else type_cursor = -1;
		
		for (var i = 0; i < cells; i++)
		{
			if (type_cursor == i) then draw_set_color(text_selected_color);
			else draw_set_color(text_color);
			draw_set_alpha(1);
		
			draw_text(x_ + width/2,y_ + (height + cell_height/2) + (cell_height * i), ___capitalize_(typeof(types[i]))); 
		}
	}
	
	___draw_set_falign_(fa_left,fa_center);
	draw_set_color(text_color);
	if (writing_type == true && string_width(keyboard_string) <= width)
	{
		new_var = keyboard_string;

		if (keyboard_check_pressed(vk_enter)) then writing_type = false;
		
		draw_text_color(x_ + 5 + string_width(new_var),y_ - box_height/2, "|", text_color,text_color,text_color,text_color, ___blink_(1,0, 30));
	}
	draw_text(x_ + 5,y_ - box_height/2, new_var);
	
	___draw_set_falign_(fa_middle,fa_center);
	if (___rectangle_hover_(x_,y_ - confirm_height, x_ + width,y_ - box_height - 1))
	{
		draw_set_alpha(0.1);
		draw_set_color(text_selected_box_color);
		draw_rectangle(x_,y_ - confirm_height, x_ + width,y_ - box_height - 1, false);
		draw_set_color(text_selected_color);

		if (mouse_check_button_pressed(mb_left))
		{
			drawing_var = false;
			if (new_var != "")
			{
				switch (last_type)
				{
					case "bool":
						new_var = bool(new_var);
					break;
					case "number":
						new_var = real(new_var);
					break;
					case "string":
						new_var = string(new_var);
					break;
						
				}
				variable_instance_set(instance, last_var, new_var);	
			}
		}
	}
	draw_set_alpha(1);
	draw_text(x_ + width/2,y_ - confirm_height + cell_height/2, "Confirm");
}

function ___capitalize_(str)
{
	var s = string_char_at(str, 1);
		
	s = string_upper(s);
	str = string_delete(str, 1,1);
	str = string_insert(s,str, 1);
	
	return str;
}

function ___draw_text_fade_(x__,y__, text)
{
	var lay = layer_create(josh_menu.depth);
	
	instance_create_layer(x,y, lay, josh_menu_text);
	with (josh_menu_text)
	{
		x_ = x__;
		y_ = y__;
		text_ = text;
	}
}

function ___array_merge_(array1, array2)
{
	var temp = [];
	var length1 = array_length(array1);
	var length2 = array_length(array2);
	
	for (var i = 0; i < length1; i++)
	{
		array_push(temp, array1[i]);
	}
	for (var i = 0; i < length2; i++)
	{
		array_push(temp, array2[i]);	
	}
	
	return temp;
}

function ___array_exists(array, value)
{
	var length = array_length(array);
	
	for (var i = 0; i < length; i++)
	{
		if (array[i] == value) then return true;	
	}
	
	return false;
}