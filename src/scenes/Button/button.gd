extends Area2D
enum ButtonSprite {BLUE_IDLE, BLUE_PRESSED, RED_IDLE, RED_PRESSED}

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
		ButtonSprite.BLUE_IDLE:
			return "blue_idle"
		ButtonSprite.BLUE_PRESSED:
			return "blue_pressed"
		ButtonSprite.RED_IDLE:
			return "red_idle"
		ButtonSprite.RED_PRESSED:
			return "red_pressed"
		_:
			return ""
