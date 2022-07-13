/// @desc
if (drawing == true)
{
	with (all)
	{
		var sprite = object_get_sprite(object_index);
		
		if (sprite != -1) 
		{
			draw_set_alpha(1);
			draw_set_color(josh_menu.box_color);
			___draw_hitbox_();
		}
	}
}