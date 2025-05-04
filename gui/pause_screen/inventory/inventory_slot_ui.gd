class_name InventorySlotUI extends Button

var slot_data: SlotData : set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label
@onready var item_description: Label = $"../../../ItemDescription"


func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	focus_entered.connect(item_focused)
	focus_exited.connect(item_unfocused)

func set_slot_data(value: SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	
	texture_rect.texture = slot_data.item_data.texture
	label.text = str(slot_data.quantity)
	
	if slot_data.quantity == 0:
		texture_rect.visible = false
		label.visible = false



func item_focused() -> void:
	if slot_data != null:
		if slot_data.item_data != null:
			if slot_data.quantity == 0:
				PauseScreen.update_item_description("", "")
			else:
				PauseScreen.update_item_description(
					slot_data.item_data.primary_name,
					slot_data.item_data.description, 
					slot_data.item_data.secondary_name)


func item_unfocused() -> void:
	PauseScreen.update_item_description("", "")
