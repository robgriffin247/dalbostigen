class_name PlayerHUDLabels extends Label


func _process(delta: float) -> void:
	if LevelManager.level_load_started:
		text = "world " + get_level().world + " level " + get_level().level 

func get_level() -> Dictionary:
	var path: String = ""
	var _world: String = ""
	var _level: String = ""
	
	for child in get_tree().root.get_children():
		if child is Level:
			path = child.scene_file_path
			_world = path.split("world_")[1].split("/level")[0]
			_level = path.split("level_")[1].replace(".tscn", "")
	
	return {"world": _world, "level": _level}
