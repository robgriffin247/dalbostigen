class_name ItemSource extends StaticBody2D

const PICKUP = preload("res://items/item_pickup/item_pickup.tscn")

@export_category("ItemSource Settings")
@export_range(1, 14, 1) var max_hp: int = 3
@export var source_texture: Texture2D

@export_category("Item Drop Settings")
@export var drops: DropData

var hp: int
var player: Player

# SourceSprite is loaded here to allow a multidrop itemsource (e.g. treasure chest dropping blueberries and chanterelles)
@onready var source_sprite: Sprite2D = $"SourceSprite"
@onready var hitbox: HitBox = $Hitbox
@onready var healthbar: Sprite2D = $Healthbar

	
func _ready() -> void:
		
	hp = max_hp
	player = PlayerManager.player
	$Hitbox.damaged.connect(take_damage)
	source_sprite.texture = source_texture


func _process(delta: float) -> void:
	pass

func take_damage(_damage: int) -> void:
	hp -= PlayerManager.player_hit_effect
	healthbar.animation_player.play(healthbar.get_animation(hp, max_hp))	
	
	if hp <= 0:
		await healthbar.animation_player.animation_finished
		drop_items()
		queue_free()

func drop_items() -> void:
	if drops == null or drops.item==null:
		return
		
	var drop_count: int = drops.get_drop_count()

	for i in drop_count:
		var drop = PICKUP.instantiate() as ItemPickup
		drop.item_data = drops.item
		get_parent().call_deferred("add_child", drop)
		drop.global_position = global_position
	
