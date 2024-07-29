extends Node2D
enum SpikedballType {LIGHT, SHADOW}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var spiked_ball_type: SpikedballType

func _ready():
	var animation = set_spiked_ball_sprite()
	animated_sprite_2d.play(animation)

func set_spiked_ball_sprite() -> String:
	match spiked_ball_type:
		0: return "light_spiked_ball"
		1: return "shadow_spiked_ball"
		_:
			return ""
