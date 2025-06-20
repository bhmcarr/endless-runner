extends Node2D
@onready var score: Label = $CanvasLayer/Score
@onready var danger_zone: Area2D = $DangerZone

func _process(delta: float) -> void:
	_scan_for_score_zones()
	
func _scan_for_score_zones():
	var score_zones = get_tree().get_nodes_in_group("score_zones")
	for zone in score_zones:
		if !zone.scored.has_connections():
			zone.scored.connect(_handle_score_zone_entered)

func _handle_score_zone_entered(points_awarded: int) -> void:
	score.add_score(points_awarded)

func _on_danger_zone_body_entered(body: Node2D) -> void:
	# restart game
	get_tree().change_scene_to_file.call_deferred("res://Scenes/main.tscn")
