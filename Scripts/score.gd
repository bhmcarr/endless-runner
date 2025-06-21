extends Label

var score: int = 0

func _ready():
	text = str(score)

func add_score(amount: int) -> void:
	score += amount
	text = str(score)
	
func reset_score():
	score = 0
	text = str(0)
