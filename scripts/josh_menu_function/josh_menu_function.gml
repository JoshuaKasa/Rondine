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
	var mx = device_mouse_x_to_gui(0);
	var my = device_mouse_y_to_gui(0);
	
	return point_in_rectangle(mx,my, start_x,start_y, end_x,end_y);
}

function ___oscillate_(from, to, duration)
{
	var TAU = pi * 2;
	var dis = (to - from) / 2;
	duration /= 120;
	 
	return from + dis + sin(((current_time / 1000) + to * TAU)/duration) * dis;
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
		
		window_set_cursor(cr_handpoint);
		if (mouse_check_button_pressed(mb_left))
		{
			if (to_change == 0)
			{
				showing_error = false;
				window_set_cursor(cr_default);
			}
			else if (to_change == 1)
			{
				drawing_typeof = false;
				window_set_cursor(cr_default);	
			}
			else
			{
				// Other messages boolean here	
			}
		}
	}
	else window_set_cursor(cr_default);
	
	draw_set_alpha(1);
	draw_text(middle_x,middle_y, "Ok");
	draw_set_color(text_color);
	draw_text(center_x,center_y, message_);
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