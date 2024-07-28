extends Area2D
enum FlagSprite { LIGHT, SHADOW }

@onready var checkpoints: Node2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var flag_sprite: FlagSprite

var is_activated: bool = false
var current_flag_sprite: String

func _ready() -> void:
	set_flag_sprite()
	animated_sprite_2d.play(current_flag_sprite + "_idle")
	animated_sprite_2d.connect("frame_changed", Callable(self, "_on_frame_changed"))

func _on_body_entered(_body) -> void:
	if not is_activated:
		animated_sprite_2d.play(current_flag_sprite + "_activate")

func _on_frame_changed() -> void:
	var activate_animation = current_flag_sprite + "_activate"
	if animated_sprite_2d.animation == activate_animation and animated_sprite_2d.frame == animated_sprite_2d.sprite_frames.get_frame_count(activate_animation) - 1:
		_on_activate_finished()

func _on_activate_finished() -> void:
	if not is_activated:
		is_activated = true
		checkpoints.add_activated_flag(self)
		animated_sprite_2d.play(current_flag_sprite + "_idle_active")

func set_flag_sprite() -> void:
	match flag_sprite:
		0: current_flag_sprite = "light"
		1: current_flag_sprite = "shadow"
