extends Label

var score: int = 0

func _ready():
	reset_score()

func update_score(new_score: int):
	text = str(new_score)
	
func reset_score():
	text = "0"
