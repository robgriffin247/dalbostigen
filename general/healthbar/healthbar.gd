class_name Healthbar extends Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass
	
func get_animation(hp: int, max_hp: int) -> String:
	var animation_frame: int = 1
	animation_frame = min(floor(14.0/max_hp)*hp, 14)
	var animation: String = "hp_" + str(animation_frame)
	return animation
