extends Node2D
@onready var spawn_timer: Timer = $SpawnTimer

@export var powerup_scenes: Array[PackedScene]

var rng = RandomNumberGenerator.new()

func _on_spawn_timer_timeout() -> void:
	# randomly grab one of the spawn points
	var spawn_points = get_tree().get_nodes_in_group("powerup_spawn_points")
	var rand_select = rng.randi_range(0, spawn_points.size() - 1)
	
	# randomly select a powerup
	var i = rng.randi_range(0, powerup_scenes.size() - 1)
	var powerup_instance = powerup_scenes[i].instantiate()
	powerup_instance.position = spawn_points[rand_select].global_position
	get_parent().add_child(powerup_instance)
