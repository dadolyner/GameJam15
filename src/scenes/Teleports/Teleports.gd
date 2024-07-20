extends Area2D

@onready var player_1: CharacterBody2D = $"../../../Player_1"
@onready var player_2: CharacterBody2D = $"../../../Player_2"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var target_portal: Area2D
@export var portal_model: int = 0
@export var controls: PlayerControls = null

var moon_over_teleport: bool = false
var sun_over_teleport: bool = false

func _ready() -> void:
	if(portal_model == 0):
		animated_sprite.play("moon")
	if(portal_model == 1):
		animated_sprite.play("sun")

func _process(_delta) -> void:
	if moon_over_teleport and Input.is_action_just_pressed(controls.interact) and portal_model == 0:
		print(target_portal.position)
		player_1.position = target_portal.position	
	if sun_over_teleport and Input.is_action_just_pressed(controls.interact) and portal_model == 1:
		player_2.position = target_portal.position

func _on_body_entered(body) -> void:
	if(body == player_1):
		player_1 = body
		moon_over_teleport = true
	if(body == player_2):
		player_2 = body
		sun_over_teleport = true
		
func _on_body_exited(body) -> void:
	if(body == player_1):
		player_1 = body
		moon_over_teleport = false
	if(body == player_2):
		player_2 = body
		sun_over_teleport = false
