extends AnimatableBody2D

var counter: int = 0

func _ready() -> void:
	add_to_group("obstacles")

func _physics_process(delta: float) -> void:
	# every frame, move the obstacle one pixel to the left
	global_position.x -= 1
	counter += 1
	
	if counter > 500:
		queue_free()
