/// @desc
if (drawing == true)
{
	with (all)
	{
		var sprite = object_get_sprite(object_index);
		
		if (sprite_exists(sprite)) 
		{
			draw_set_alpha(1);
			draw_set_color(rondine_menu.box_color);
			___draw_hitbox_();
		}
	}
}
