class_name DropData extends Resource

@export var item: ItemData
@export_range(1, 20, 1) var min_amount: int = 1
@export_range(1, 20, 1) var max_amount: int = 5
 
func get_drop_count() -> int:	
	return randi_range(min_amount, max_amount)
	# come back to this to make a non-uniform distribution
	# establish an resource gathered state then return to ep19, 7:20
