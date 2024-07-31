extends Area2D
enum BulletSprite {LIGHT, SHADOW}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: float = 200.0
var direction: Vector2

func _physics_process(delta) -> void:
	global_position += direction * SPEED * delta

func set_sprite(sprite: BulletSprite) -> void:
	match sprite:
		0: animated_sprite_2d.play("light")
		1: animated_sprite_2d.play("shadow")

func set_direction(bullet_direction: Vector2) -> void:
	direction = bullet_direction

func _on_body_entered(_body):
	self.queue_free()
