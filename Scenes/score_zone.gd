extends Area2D

signal scored(point_amount: int)

func _ready() -> void:
	add_to_group("score_zones")

func _on_body_entered(body: Node2D) -> void:
	scored.emit(1)
