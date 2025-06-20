extends Node2D
@onready var score: Label = $CanvasLayer/Score

func _process(delta: float) -> void:
	_scan_for_score_zones()
	
func _scan_for_score_zones():
	var score_zones = get_tree().get_nodes_in_group("score_zones")
	for zone in score_zones:
		if !zone.scored.has_connections():
			zone.scored.connect(_handle_score_zone_entered)

func _handle_score_zone_entered(points_awarded: int) -> void:
	score.add_score(points_awarded)
