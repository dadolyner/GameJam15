extends Area2D

@onready var base_pickup: Node2D = $".."

func _on_body_entered(body) -> void:
	base_pickup.pickup_item(self, body)
