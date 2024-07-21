extends Area2D
enum LeverSprite {ON, OFF}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var on_sprite: LeverSprite = LeverSprite.ON
@export var off_sprite: LeverSprite = LeverSprite.OFF
@export var player: CharacterBody2D
@export var player_controls: PlayerControls

var is_close_to_lever: bool = false
var lever_state: int = 0

func _ready() -> void:
	animated_sprite_2d.play(get_animation_sprite(off_sprite))
	
func _process(_delta) -> void:
	if Input.is_action_just_pressed(player_controls.interact) and is_close_to_lever:
		if lever_state == 0:
			lever_state = 1
			animated_sprite_2d.play(get_animation_sprite(on_sprite))
		else:
			lever_state = 0
			animated_sprite_2d.play(get_animation_sprite(off_sprite))

func _on_body_entered(body) -> void:
	if body == player:
		is_close_to_lever = true
	else:
		return

func _on_body_exited(body) -> void:
	if body == player:
		is_close_to_lever = false
	else:
		return

func get_animation_sprite(sprite: LeverSprite) -> String:
	match sprite:
		LeverSprite.ON:
			return "on"
		LeverSprite.OFF:
			return "off"
		_:
			return ""

func get_lever_state() -> int:
	return lever_state
