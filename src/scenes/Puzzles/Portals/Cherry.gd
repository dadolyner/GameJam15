extends Area2D

@onready var portal_puzzle: Node2D = $"../.."

func _on_body_entered(_body) -> void:
	portal_puzzle.pickup_cherry(self)
