extends Node2D
@onready var score: Label = $CanvasLayer/Score
@onready var danger_zone: Area2D = $DangerZone
@onready var player: CharacterBody2D = null
@onready var retry_menu: Control = $CanvasLayer/RetryMenu
@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var gameplay_message: Label = $CanvasLayer/GameplayMessage
@onready var multiplier_label: Label = $CanvasLayer/Multiplier
@onready var life_counter: Control = $CanvasLayer/LifeCounter

var player_scene: PackedScene = load("res://Scenes/player.tscn")

var is_game_over: bool = false

var current_score: int = 0
var best_score: int = 0
var multiplier: int = 1
var lives: int = 1

func _ready():
	_spawn_player()
	life_counter.update_life_amount(lives)

func _process(_delta: float) -> void:
	_scan_for_score_zones()
	_scan_for_powerups()
	
func _scan_for_powerups():
	var powerups = get_tree().get_nodes_in_group("powerups")
	for powerup in powerups:
		if !powerup.powerup_collected.has_connections():
			powerup.powerup_collected.connect(_handle_powerup_collected)
			if powerup.is_in_group("multipliers"):
				powerup.multiplier_collected.connect(_handle_multiplier_collected)
	
func _scan_for_score_zones():
	var score_zones = get_tree().get_nodes_in_group("score_zones")
	for zone in score_zones:
		if !zone.scored.has_connections():
			zone.scored.connect(_handle_score_zone_entered)

# Handle clicks
func _input(event:InputEvent) -> void:
	if (event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT) || (event is InputEventKey && event.is_action_pressed("ui_accept")):
		if !is_game_over:
			player.jump()
		else:
			_restart_game()

func _handle_score_zone_entered(points_awarded: int) -> void:
	current_score += points_awarded * multiplier
	score.update_score(current_score)

func _handle_powerup_collected(new_message: String, action: String):
	gameplay_message.show_message(new_message)
	if action == "extra_life":
		_increment_lives(1)
	
func _handle_multiplier_collected(amount: int):
	multiplier += amount
	multiplier_label.text = "x" + str(multiplier)

func _on_danger_zone_body_entered(_body: Node2D) -> void:
	_decrement_lives(1)
	if lives == 0:
		_start_game_over()
	else:
		_spawn_player()
	
func _start_game_over():
	is_game_over = true
	gameplay_message.hide()
	if current_score > best_score:
		best_score = current_score
	retry_menu.show_score(current_score, best_score)
	
func _increment_lives(amount: int):
	if lives < 99:
		lives += amount
		life_counter.update_life_amount(lives)

func _decrement_lives(amount: int):
	lives -= amount
	life_counter.update_life_amount(lives)
	
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
	current_score = 0
	score.reset_score()
	multiplier_label.text = "x1"
	
	# reset multiplier
	multiplier = 1
	
	# hide messages
	gameplay_message.hide()
	
	# reset lives
	lives = 1
	life_counter.update_life_amount(1)
