extends Node2D
@onready var score: Label = $CanvasLayer/Score
@onready var danger_zone: Area2D = $DangerZone
@onready var player: CharacterBody2D = null
@onready var retry_menu: Control = $CanvasLayer/RetryMenu
@onready var player_spawn: Marker2D = $PlayerSpawn

var player_scene: PackedScene = load("res://Scenes/player.tscn")

var is_game_over: bool = false

# TODO: pull current score up from label into main scene
var best_score: int = 0

func _ready():
	_spawn_player()

func _process(delta: float) -> void:
	_scan_for_score_zones()
	
func _scan_for_score_zones():
	var score_zones = get_tree().get_nodes_in_group("score_zones")
	for zone in score_zones:
		if !zone.scored.has_connections():
			zone.scored.connect(_handle_score_zone_entered)

# Handle clicks			
func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if !is_game_over:
				player.jump()
			else:
				_restart_game()

func _handle_score_zone_entered(points_awarded: int) -> void:
	score.add_score(points_awarded)

func _on_danger_zone_body_entered(body: Node2D) -> void:
	_start_game_over()
	
func _start_game_over():
	is_game_over = true
	if score.score > best_score:
		best_score = score.score
	retry_menu.show_score(score.score, best_score)
	
func _spawn_player():
	if player != null:
		player.queue_free()
	player = player_scene.instantiate()
	player.position = player_spawn.global_position
	add_child(player)
	
func _restart_game():
	is_game_over = false
	retry_menu.hide_score()
	
	# reset player
	_spawn_player()

	# reset obstacles
	get_tree().call_group("obstacles", "queue_free")
	
	# reset score
	score.reset_score()
