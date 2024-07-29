extends Area2D

@onready var timer: Timer = $Timer
@onready var hurt_sound: AudioStreamPlayer = $HurtSound

func _on_body_entered(body) -> void:
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	
	if not hurt_sound.is_playing():
		hurt_sound.pitch_scale = randf_range(0.8, 1.2)
		hurt_sound.play()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	GameManager.reset_current_level_points()
	Globals._load_scene()
