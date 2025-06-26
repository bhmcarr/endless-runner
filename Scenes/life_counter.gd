extends Control
@onready var label: Label = $Label

func update_life_amount(new_value: int):
	if new_value < 9:
		label.text = "x0" + str(new_value)
	else:
		label.text = "x" + str(new_value)
