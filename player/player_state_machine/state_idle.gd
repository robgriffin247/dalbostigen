class_name StateIdle extends State

@onready var walk: State = $"../Walk"
@onready var gather: State = $"../Gather"

func enter() -> void:
	player.update_animation("idle")
	
func exit() -> void:
	pass

func process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_input: InputEvent) -> State:
	if _input.is_action_pressed("gather"):
		return gather
	return null
