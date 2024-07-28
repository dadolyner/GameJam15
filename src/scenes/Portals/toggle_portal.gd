extends Area2D

@onready var portals: Node2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var lever: Area2D = $"../Lever"

@export var portal_target: Area2D

var is_over_portal: bool = false
var is_portal_active: bool

func _ready() -> void:
	get_portal_animation()

func _process(_delta) -> void:
	is_portal_active = lever.get_lever_state() == 1
	get_portal_animation()
	
	if Input.is_action_just_pressed(portals.player_controls.interact) and is_over_portal and is_portal_active:
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

func get_portal_animation() -> void:
	if is_portal_active == false:
		match portals.portal_model:
			0: animated_sprite_2d.play("light_off")
			1: animated_sprite_2d.play("shadow_off")
	else:
		match portals.portal_model:
			0: animated_sprite_2d.play("light")
			1: animated_sprite_2d.play("shadow")
