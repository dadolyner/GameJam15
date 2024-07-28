extends Area2D
enum ButtonSprite {SHADOW_IDLE, SHADOW_PRESSED, LIGHT_IDLE, LIGHT_PRESSED }

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

@export var idle_sprite: ButtonSprite
@export var pressed_sprite: ButtonSprite

func _ready() ->void:
	animated_sprite_2d.play(get_animation_sprite(idle_sprite))

func _on_body_entered(_body) -> void:
	animated_sprite_2d.play(get_animation_sprite(pressed_sprite))

func _on_body_exited(_body) -> void:
	animated_sprite_2d.play(get_animation_sprite(idle_sprite))

func get_animation_sprite(sprite: ButtonSprite) -> String:
	match sprite:
		0: return "shadow_idle"
		1: return "shadow_pressed"
		2: return "light_idle"
		3: return "light_pressed"
		_:
			return ""
