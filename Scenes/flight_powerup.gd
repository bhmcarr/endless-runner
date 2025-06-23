extends Area2D

var counter: int = 0

signal powerup_collected(message: String)

func _ready() -> void:
	add_to_group("powerups")

func _physics_process(_delta: float) -> void:
	global_position.x -= 1
	counter += 1
	
	if counter > 500:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if  body.has_method("activate_flying"): # player?
		body.activate_flying()
		powerup_collected.emit("FLYING!!", "flying")
		queue_free()
