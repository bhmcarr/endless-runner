extends Node2D

@onready var obstacle_s: PackedScene = load("res://Scenes/obstacle_s.tscn")
@onready var obstacle_m: PackedScene = load("res://Scenes/obstacle_m.tscn")
@onready var obstacle_l: PackedScene = load("res://Scenes/obstacle_l.tscn")
@onready var spawn_timer: Timer = $SpawnTimer

var rng = RandomNumberGenerator.new()

func _on_spawn_timer_timeout() -> void:
	# randomly switch time between obstacle spawns
	spawn_timer.wait_time = rng.randf_range(0.33, 2)
	
	# randomly select an obstacle and add it to the main scene
	var rand_selection = rng.randi_range(0, 2)
	var obstacle_instance
	match rand_selection:
		0: obstacle_instance = obstacle_s.instantiate()
		1: obstacle_instance = obstacle_m.instantiate()
		2: obstacle_instance = obstacle_l.instantiate()
	obstacle_instance.position = self.global_position
	get_parent().add_child(obstacle_instance)
