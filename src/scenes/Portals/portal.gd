extends Area2D

@onready var portals: Node2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var portal_target: Area2D

var is_over_portal: bool = false

func _ready() -> void:
	match portals.portal_model:
		0: animated_sprite_2d.play("light")
		1: animated_sprite_2d.play("shadow")

func _process(_delta) -> void:
	if Input.is_action_just_pressed(portals.player_controls.interact) and is_over_portal:
		portals.player.position = portal_target.position

func _on_body_entered(body: Node) -> void:
	if body == portals.player:
		is_over_portal = true
	else:
		return
		
func _on_body_exited(body) -> void:
	if body == portals.player:
		is_over_portal = false
	else:
		return
