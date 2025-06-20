extends Node2D

@onready var obstacle_s: PackedScene = load("res://Scenes/obstacle_s.tscn")
@onready var obstacle_m: PackedScene = load("res://Scenes/obstacle_m.tscn")
@onready var obstacle_l: PackedScene = load("res://Scenes/obstacle_l.tscn")
@onready var spawn_timer: Timer = $SpawnTimer

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var rand_selection = rng.randi_range(0, 2)
	var obstacle_instance
	
	match rand_selection:
		0:
			obstacle_instance = obstacle_s.instantiate()
		1:
			obstacle_instance = obstacle_m.instantiate()
		2:
			obstacle_instance = obstacle_l.instantiate()
	
	obstacle_instance.position = self.global_position
	
	get_parent().add_child(obstacle_instance)
