extends TileMapLayer

var counter: int = 0

func _physics_process(delta: float) -> void:
	# every frame, move the terrain one pixel to the left
	position.x -= 1
	counter += 1
	if counter > 8:
		position.x = 0
		counter = 0
