@tool
class_name ItemPickup extends CharacterBody2D

@export var item_data: ItemData : set = _set_item_data

var movement_speed: float = 140.0
var decel_rate: float = 4.0

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_update_texture()
	area_2d.monitorable = false
	animation_player.play("bounce")
	velocity = -(global_position.direction_to(PlayerManager.player.global_position).rotated(randf_range(-1.5,1.5))) * (movement_speed * randf_range(0.6,1.8))
	if Engine.is_editor_hint():
		return
	await get_tree().create_timer(0.1).timeout
	area_2d.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	velocity -= velocity * delta * decel_rate
	

func _on_body_entered(b) -> void:
	if b is Player:
		if item_data:
			if PlayerManager.INVENTORY_DATA.add_item(item_data):
				item_picked_up()


func item_picked_up() -> void:
	area_2d.body_entered.disconnect(_on_body_entered)
	queue_free()
	# see part 17 (16:00) for playing sounds


func _set_item_data(value: ItemData) -> void:
	item_data = value
	_update_texture()


func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
