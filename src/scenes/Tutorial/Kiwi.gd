extends Area2D

@onready var collectables: Node2D = $".."

func _on_body_entered(_body) -> void:
	collectables.add_point()
	self.queue_free()
