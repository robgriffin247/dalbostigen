class_name HitBox extends Area2D

signal damaged(damage: int)

func _ready() -> void:
	pass


func take_damage(damage: int) -> void:
	damaged.emit(damage)

	
