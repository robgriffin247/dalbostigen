extends CanvasLayer

@onready var button_save: Button = $Control/HBoxContainer/ButtonSave
@onready var button_load: Button = $Control/HBoxContainer/ButtonLoad

var is_paused: bool = false


func _ready() -> void:
	hide_pause_screen()
	button_save.pressed.connect(_on_save_pressed)
	button_load.pressed.connect(_on_load_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if not is_paused:
			show_pause_screen()
		else:
			hide_pause_screen()

		get_viewport().set_input_as_handled()


func show_pause_screen() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	button_save.grab_focus()
	PlayerHud.visible = false


func hide_pause_screen() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	PlayerHud.visible = true


func _on_save_pressed() -> void:
	if not is_paused:
		return
	SaveManager.save_game()
	hide_pause_screen()
	
	
func _on_load_pressed() -> void:
	if not is_paused:
		return
	SaveManager.load_game()
	await LevelManager.level_load_started
	hide_pause_screen()
