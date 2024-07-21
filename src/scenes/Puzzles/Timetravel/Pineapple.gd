extends Area2D

@onready var timetravel_puzzle: Node2D = $".."
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(_body) -> void:
	timetravel_puzzle.start_timetravel(self)
