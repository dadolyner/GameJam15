extends Node2D
enum SpikesType {LIGHT, SHADOW}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var spikes_type: SpikesType

func _ready():
	var animation = set_spikes_sprite()
	animated_sprite_2d.play(animation)

func set_spikes_sprite() -> String:
	match spikes_type:
		0: return "light_spikes"
		1: return "shadow_spikes"
		_:
			return ""
