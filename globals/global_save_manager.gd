extends Node


const SAVE_PATH = "user://"


signal game_loaded
signal game_saved

var current_save: Dictionary = {
	scene_path = "",
	player = {
		position = {x = 0.0, y = 0.0}
	},
	inventory = [],
}


func save_game() -> void:
	update_player_data()
	update_scene_path()
	update_inventory_data()
	var file: FileAccess = FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()


func load_game() -> void:
	var file: FileAccess = FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	var json: JSON = JSON.new()
	json.parse(file.get_line())
	var save_dict: Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	LevelManager.load_new_level(current_save.scene_path, "", Vector2.ZERO)
	await LevelManager.level_load_started
	print(current_save.player.position)
	PlayerManager.set_player_position(Vector2(current_save.player.position.x,current_save.player.position.y))
	PlayerManager.INVENTORY_DATA.parse_save_data(current_save.inventory)
	await LevelManager.level_loaded
	
	game_loaded.emit()
	
	

func update_player_data() -> void:
	var player: Player = PlayerManager.player
	current_save.player.position.x = player.global_position.x
	current_save.player.position.y = player.global_position.y


func update_scene_path() -> void:
	var path: String = ""
	for child in get_tree().root.get_children():
		if child is Level:
			path = child.scene_file_path
	current_save.scene_path = path


func update_inventory_data() -> void:
	current_save.inventory = PlayerManager.INVENTORY_DATA.get_save_data()
