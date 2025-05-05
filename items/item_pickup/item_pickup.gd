@tool
class_name ItemPickup extends Node

@export var item_data: ItemData : set = _set_item_data

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	
	area_2d.body_entered.connect(_on_body_entered)
	
	

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
