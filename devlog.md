### Project Setup

1. Set appropriate window sizes, strecth mode to viewport, and texture rendering to nearest in project settings
1. Add Node2D called `Playground`
1. Add a CharacterBody2D called `Player` as a child of `Playground`
1. Save `Playground` and `Player` as scenes (`./playground.tscn` and `./player/player.tscn`)
1. Add a CollisionShape2D node to `Player`, adding a suitable shape
1. Add a Sprite2D node to `Player`, adding a suitable texture
1. Adjust the collision shape size/position, and sprite position
1. Run the project setting playground as the main scene

### Adding Player Control & States

1. Add direction controls to the input map

1. Add a player class and attach to the ``Player``

	```
	class_name Player extends CharacterBody2D

	var cardinal_direction: Vector2 = Vector2.DOWN
	var direction: Vector2 = Vector2.ZERO

	@onready var animation_player: AnimationPlayer = $AnimationPlayer
	@onready var sprite: Sprite2D = $Sprite2D
	@onready var state_machine: PlayerStateMachine = $StateMachine


	func _ready() -> void:
		state_machine.initialise(self)


	func _process(_delta: float) -> void:
		direction = Vector2(
			Input.get_axis("left", "right"),
			Input.get_axis("up", "down")
		).normalized() 


	func _physics_process(_delta: float) -> void:
		move_and_slide()


	func set_direction() -> bool:
		var new_direction: Vector2 = cardinal_direction
		if direction == Vector2.ZERO:
			return false
		
		if direction.y == 0:
			new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
		elif direction.x == 0:
			new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
		if new_direction == cardinal_direction:
			return false
		
		cardinal_direction = new_direction
		sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
		return true


	func update_animation(state: String) -> void:
		animation_player.play(state + "_" + animation_direction())


	func animation_direction() -> String:
		if cardinal_direction == Vector2.DOWN:
			return "down"
		elif cardinal_direction == Vector2.UP:
			return "up"
		else:
			return "side"

	```

1. Add an AnimationPlayer node to `Player`, adding animations for walk/idle and up, down and side.

1. Create a State class, setting a blueprint for `enter()` and `exit()` to control what happens when entering and exiting the state, and `process()`, `physics()` and `handle_input()` functions that will <!-- TODO --> <!-- TODO --> <!-- TODO -->

	```
	class_name State extends Node

	static var player: Player

	func _ready() -> void:
		pass

	func enter() -> void:
		pass
		
	func exit() -> void:
		pass

	func process(_delta: float) -> State:
		return null

	func physics(_delta: float) -> State:
		return null

	func handle_input(_input: InputEvent) -> State:
		return null
	```

1. Create a ``PlayerStateMachine`` class to orchestrate player state, most importantly this `change_state()` function

	```
	class_name PlayerStateMachine extends Node

	var states: Array[State]
	var previous_state: State
	var current_state: State

	func _ready() -> void:
		process_mode = Node.PROCESS_MODE_DISABLED

	func _process(delta: float) -> void:
		change_state(current_state.process(delta))

	func _physics_process(delta: float) -> void:
		change_state(current_state.physics(delta))

	func  _unhandled_input(event: InputEvent) -> void:
		change_state(current_state.handle_input(event))

	func initialise(_player: Player) -> void:
		states = []
		
		for child in get_children():
			if child is State:
				states.append(child)
		
		if states.size() > 0:
			states[0].player = _player
			change_state(states[0])
			process_mode = Node.PROCESS_MODE_INHERIT

	func change_state(new_state: State) -> void:
		if new_state == null || new_state == current_state:
			return
		
		if current_state:
			current_state.exit()		
		
		previous_state = current_state
		current_state = new_state
		
		current_state.enter()
	```

1. Add a Node called ``StateMachine`` to `Player`, with child Nodes `Idle` and `Walk`, attaching the ``PlayerStateMachine`` class to the ``StateMachine`` node

1. Create and attach ``StateIdle`` and ``StateWalk`` classes

	```
	class_name StateIdle extends State

	@onready var walk: State = $"../Walk"

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
		return null
	```

	```
	class_name StateWalk extends State

	@export var walk_speed: float = 120.0
	@onready var idle: State = $"../Idle"

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
		return null
	```