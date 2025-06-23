extends Control
@onready var label: Label = $Label

func update_life_amount(new_value: int):
	label.text = "x" + str(new_value)
