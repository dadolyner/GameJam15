extends Area2D
enum LeverType { LIGHT, SHADOW }
enum LeverSprite { ON, OFF }

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var lever_type: LeverType
@export var lever_sprite: LeverSprite
@export var player: CharacterBody2D
@export var player_controls: PlayerControls

var on_sprite: String
var off_sprite: String
var is_close_to_lever: bool = false
var lever_state: int = 0

func _ready() -> void:
	get_lever_sprite()
	animated_sprite_2d.play(off_sprite)
	
func _process(_delta) -> void:
	if Input.is_action_just_pressed(player_controls.interact) and is_close_to_lever:
		if lever_state == 0:
			lever_state = 1
			animated_sprite_2d.play(on_sprite)
		else:
			lever_state = 0
			animated_sprite_2d.play(off_sprite)

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

func get_lever_sprite() -> void:
		match lever_type:
			0: 
				on_sprite = "light_on"
				off_sprite = "light_off"
			1: 
				on_sprite = "shadow_on"
				off_sprite = "shadow_off"
				

func get_lever_state() -> int:
	return lever_state
