# keeps track of what is in the inventory
class_name InventoryData extends Resource

@export var slots: Array[SlotData]

func add_item(item: ItemData, quantity: int = 1) -> bool:
	for s in slots:
		if s: # check if there is a slotdata in the slot
			if s.item_data == item: # is this the same item type as the item being added
				s.quantity += quantity
				return true
	
	# This should not be needed as slots will be preassigned - this is adding the item if not in inventory
	for i in slots.size():
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = quantity
			slots[i] = new
			return true
	
	return false


func get_save_data() -> Array:
	var item_save: Array = []
	for i in slots.size():
		item_save.append(item_to_save(slots[i]))
	return item_save
	

func item_to_save(slot: SlotData) -> Dictionary:
	var result = {item = "", quantity = 0}
	if slot != null:
		result.quantity = slot.quantity
		if slot.item_data != null:
			result.item = slot.item_data.resource_path
	return result


func parse_save_data(save_data: Array) -> void:
	var array_size = slots.size()
	slots.clear()
	slots.resize(array_size)
	for i in save_data.size():
		slots[i] = item_from_save(save_data[i])
	


func item_from_save(dict: Dictionary) -> SlotData:
	if dict.item == "":
		return null
	var new_slot: SlotData = SlotData.new()
	new_slot.item_data = load(dict.item)
	new_slot.quantity = int(dict.quantity)
	return new_slot
