class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction: Vector2)
signal enemy_damaged()

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp: int = 3

@export_category("Drops")
@export var items: Array[DropData]


var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var player: Player
var invulnerable: bool = false

@onready var source_sprite: Sprite2D = $SourceSprite
@onready var hitbox: HitBox = $Hitbox

func _ready() -> void:
	velocity = DIR_4[0] * 0 # ItemSource will be static! A velocity is needed for the drops to have a direction away from the player
	#enemy_damaged.connect(_on_damaged)
	hitbox.damaged.connect(_take_damage)


func _process(delta: float) -> void:
	# knockback details pt2 18:30
	# velocity -= velocity * 10 * delta
	pass
	


func _physics_process(_delta: float) -> void:
	move_and_slide()


func set_direction(_new_direction: Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id: int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
	
	direction_changed.emit(new_direction)
	cardinal_direction = new_direction
	
	return true


func _take_damage(damage: int) -> void:
	hp -= damage
	enemy_damaged.emit()
