/// @desc
if (instance_number(object_index) > 1) then instance_destroy();

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

with (instance)
{
	image_index = floor(image_index);
	
	if (image_number == 1) then image_speed = 0;
}

// Game saving and loading
if (keyboard_check_pressed(shortcut_save))
{
    // Create a JSON object representing the game state
    var game_state = {
        objs: []
    };

    // Add data for each object instance
    with (all)
    {
		if (id != other.id)
		{
	        var object_data = {
				obj_name: "",
	            obj_variables: {
				}
	        };

			// Adding default instance variables
			for (var i = 0; i < array_length(other.default_vars); i++)
			{
				var def_var_value = variable_instance_get(id, other.default_vars[i]);
				variable_struct_set(object_data.obj_variables, other.default_vars[i], def_var_value);
			}	
		
	        // Add instance variable data
			object_data.obj_name = object_get_name(object_index);
			var variable_count = variable_instance_names_count(id);
			var object_variables = variable_instance_get_names(id);
			for (var i = 0; i < variable_count; i++)
			{
				var var_value = variable_instance_get(id, object_variables[i]);
				variable_struct_set(object_data.obj_variables, object_variables[i], var_value);
			}
			array_push(game_state.objs, object_data);
		}
	}
	
    // Save the game state to a file
	var file_path = get_save_filename("JSON Files (*.json)|*.json", "Rondine debug save");
	if (file_path != "")
	{
	    // Save the game state to the chosen file path
	    var file = file_text_open_write(file_path);
		game_state = json_stringify(game_state, true);
	    file_text_write_string(file, game_state);
	    file_text_close(file);
	}
}

// Load the game state
if (keyboard_check_pressed(shortcut_load))
{
	var file_path = get_open_filename("JSON Files (*.json)|*.json", "Load Game State From");
    if (file_path != "") 
	{
	    // Read the contents of the file
	    var file = file_text_open_read(file_path);
	    var game_state_json = "";
	    while (!file_text_eof(file))
	    {
	        game_state_json += file_text_readln(file);
	    }
	    file_text_close(file);
    
	    // Parse the JSON data
	    var game_state = json_parse(game_state_json);
	
        // Destroy all existing objects
        with (all) 
		{
            if (id != other.id) 
			{
                instance_destroy();
            }
        }
        
        // Recreate objects with their coordinates and variables
		var game_objs = game_state.objs;
		var obj_number = array_length(game_objs);
		for (var i = 0; i < obj_number; i++)
		{
			var curr_obj = game_objs[i];
			var curr_obj_name = curr_obj.obj_name;
			var obj_created = instance_create_layer(curr_obj.obj_variables.x,curr_obj.obj_variables.y, "Instances", asset_get_index(curr_obj_name));
			
			with (obj_created)
			{
				var curr_obj = game_objs[i];
				var all_vars = variable_instance_get_names(id);
				var num_vars = array_length(all_vars);
				var struct_variables = variable_struct_get_names(curr_obj.obj_variables);
				
				for (var j = 0; j < num_vars; j++)
				{
					var var_value = variable_struct_get(curr_obj.obj_variables, struct_variables[j]);
					
					variable_instance_set(id, all_vars[j], var_value);
				}
			}
		}
    }
}
