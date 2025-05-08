class_name ItemSource extends CharacterBody2D

#signal source_damaged()

const PICKUP = preload("res://items/item_pickup/item_pickup.tscn") ##

@export_category("ItemSource Settings")
@export_range(1,14,1) var max_hp: int = 3

@export_category("Item Drop Settings")
@export var drops: DropData

var hp: int
var player: Player

@onready var host: Node2D = $".."
@onready var sprite: Sprite2D = $"../Sprite2D"

@onready var hitbox: HitBox = $Hitbox
@onready var healthbar: Sprite2D = $Healthbar


func _ready() -> void:
	hp = max_hp
	player = PlayerManager.player
	$Hitbox.damaged.connect(take_damage)
	velocity = Vector2.ZERO * 0

func _process(delta: float) -> void:
	velocity -= global_position.direction_to(player.global_position) * 10 * delta
	

func take_damage(_damage: int) -> void:
	hp -= PlayerManager.player_hit_effect
	healthbar.animation_player.play(healthbar.get_animation(hp, max_hp))	
	
	if hp <= 0:
		velocity = 200 * Vector2.RIGHT
		await healthbar.animation_player.animation_finished
		
		drop_items()
		
		# Remove source
		host.queue_free()
		

func drop_items() -> void:
	if drops == null or drops.item==null:
		print("no drop")
		return
		
	var drop_count: int = drops.get_drop_count()

	for i in drop_count:
		var drop = PICKUP.instantiate() as ItemPickup
		drop.item_data = drops.item
		host.get_parent().call_deferred("add_child", drop)
		drop.global_position = global_position
	
