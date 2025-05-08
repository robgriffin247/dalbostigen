class_name StateGather extends State


@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var hurtbox: HurtBox = $"../../Interactions/Hurtbox"

var decelerate_rate: float = 16
var gathering: bool = false

func enter() -> void:
	player.update_animation("gather")
	animation_player.animation_finished.connect(end_gather)
	gathering = true
	await get_tree().create_timer(0.15).timeout
	if gathering:
		hurtbox.monitoring = true
	
	
func exit() -> void:
	animation_player.animation_finished.disconnect(end_gather)
	gathering = false
	hurtbox.monitoring = false

func process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_rate * _delta
	if gathering==false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_input: InputEvent) -> State:
	return null

func end_gather(_new_animation_name: String) -> void:
	gathering = false
	hurtbox.monitoring = false
