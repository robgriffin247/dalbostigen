class_name StateWalk extends State

@export var walk_speed: float = 90.0
@onready var idle: State = $"../Idle"
@onready var gather: State = $"../Gather"

func enter() -> void:
	player.update_animation("walk")

func exit() -> void:
	pass

func process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * walk_speed
	
	if player.set_direction():
		player.update_animation("walk")
		
	return null
	
func physics(_delta: float) -> State:
	return null

func handle_input(_input: InputEvent) -> State:
	if _input.is_action_pressed("gather"):
		return gather
	return null
