extends TileMapLayer

var counter: int = 0

func _physics_process(delta: float) -> void:
	# every frame, move the terrain one pixel to the left
	position.x -= 1
	counter += 1
	
	# after the terrrain has moved one tile-width, reset the position and counter
	# this gives the illusion of infinitely scrolling
	if counter > 8:
		position.x = 0
		counter = 0
