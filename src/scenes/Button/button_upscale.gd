extends Node2D

const MAX_SCALE: float = 3.0
const SCALE_RATIO: float = 0.05
const SCALE_TIMEOUT: float = 0.05
var player_on_button: bool = false

func _on_area_2d_body_entered(body) -> void:
	player_on_button = true
	
	while player_on_button and body.scale.x < MAX_SCALE:
		body.scale.x += SCALE_RATIO
		body.scale.y += SCALE_RATIO
		await get_tree().create_timer(SCALE_TIMEOUT).timeout
	
func _on_area_2d_body_exited(_body) -> void:
	player_on_button = false
