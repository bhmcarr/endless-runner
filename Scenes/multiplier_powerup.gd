extends Area2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

signal multiplier_collected(amount: int)
signal powerup_collected(message: String)

var multiplier_amount: int = 2

var mult_amounts = [2, 3, 4, 5, 9]
var rng = RandomNumberGenerator.new()
var counter: int = 0

func _ready():
	add_to_group("powerups")
	add_to_group("multipliers")
	
	var i = rng.randi_range(0, mult_amounts.size() - 1)
	multiplier_amount = mult_amounts[i]
	
	match multiplier_amount:
		2: sprite.play("2")
		3: sprite.play("3")
		4: sprite.play("4")
		5: sprite.play("5")
		9: sprite.play("9")
		

func _physics_process(delta: float) -> void:
	global_position.x -= 1
	counter += 1
	
	if counter > 500:
		queue_free()
		
func _on_body_entered(body: Node2D) -> void:
	multiplier_collected.emit(multiplier_amount)
	powerup_collected.emit("MULTIPLIER X" + str(multiplier_amount), "multiplier")
	queue_free()
