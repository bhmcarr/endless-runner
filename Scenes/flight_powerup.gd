extends Area2D

var counter: int = 0

func _physics_process(delta: float) -> void:
	global_position.x -= 1
	counter += 1
	
	if counter > 500:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if  body.has_method("activate_flying"): # player?
		body.activate_flying()
		queue_free()
