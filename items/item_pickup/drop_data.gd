class_name DropData extends Resource

@export var item: ItemData

@export_range(1, 20, 1) var min_amount: int = 1
@export_range(1, 20, 1) var max_amount: int = 3

func get_drop_count() -> int:	
	var count: int = randi_range(min_amount, max_amount)
	return count
