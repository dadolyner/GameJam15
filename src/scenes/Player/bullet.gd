extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED: float = 250.0
var direction: Vector2

func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	self.queue_free()

func _physics_process(delta) -> void:
	global_position += direction * SPEED * delta

func _on_body_entered(body) -> void:
	if body.is_in_group("Enemy"):
		body.queue_free()
	self.queue_free()

func set_sprite(sprite: int) -> void:
	match sprite:
		0: animated_sprite_2d.play("light")
		1: animated_sprite_2d.play("shadow")

func set_direction(bullet_direction: Vector2) -> void:
	direction = bullet_direction
