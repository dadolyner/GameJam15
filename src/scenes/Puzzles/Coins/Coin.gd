extends Area2D

@onready var coin_puzzle: Node2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body) -> void:
	coin_puzzle.pickup_coin(self, body)


func _on_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "explosion":
		self.visible = false
