extends Control
@onready var your_score_value: Label = $YourScoreValue
@onready var best_score_value: Label = $BestScoreValue

func _ready() -> void:
	hide()

func show_score(current_score: int, best_score: int):
	your_score_value.text = str(current_score)
	best_score_value.text = str(best_score)
	show()

func hide_score():
	hide()
