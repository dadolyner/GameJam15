extends Area2D

@onready var checkpoints: Node2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_activated: bool = false

func _ready() -> void:
	animated_sprite_2d.connect("frame_changed", Callable(self, "_on_frame_changed"))

func _on_body_entered(_body) -> void:
	if not is_activated:
		animated_sprite_2d.play("activate")

func _on_frame_changed() -> void:
	if animated_sprite_2d.animation == "activate" and animated_sprite_2d.frame == animated_sprite_2d.sprite_frames.get_frame_count("activate") - 1:
		_on_activate_finished()

func _on_activate_finished() -> void:
	if not is_activated:
		is_activated = true
		checkpoints.add_activated_flag(self)
		animated_sprite_2d.play("idle_active")
