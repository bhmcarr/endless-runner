extends Area2D

signal powerup_collected(message: String)

var counter: int = 0

func _ready() -> void:
	add_to_group("powerups")

func _physics_process(delta: float) -> void:
	global_position.x -= 1
	counter += 1
	
	if counter > 500:
		queue_free()
		
func _on_body_entered(body: Node2D) -> void:
	powerup_collected.emit("EXTRA LIFE!!", "extra_life")
	queue_free()
