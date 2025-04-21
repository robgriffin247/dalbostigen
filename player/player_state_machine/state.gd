class_name State extends Node

static var player: Player

func _ready() -> void:
	pass

func enter() -> void:
	pass
	
func exit() -> void:
	pass


# If any of these return a state, the process of changing state will be run (see PlayerStateMachine process, physics and unhandled)
func process(_delta: float) -> State:
	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_input: InputEvent) -> State:
	return null
