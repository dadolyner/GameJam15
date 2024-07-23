extends CharacterBody2D

@onready var raycast_left: RayCast2D = $Raycasts/RaycastLeft
@onready var raycast_right: RayCast2D = $Raycasts/RaycastRight
@onready var raycast_front: RayCast2D = $Raycasts/RaycastFront
@onready var raycast_back: RayCast2D = $Raycasts/RaycastBack
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: float = 60.0
const GRAVITY: float = 900.0
const FALL_GRAVITY: float = 1300.0

var direction: int = -1

func _physics_process(delta) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	if raycast_right.is_colliding() or not raycast_back.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	
	if raycast_left.is_colliding() or not raycast_front.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true
	
	velocity.x = direction * SPEED
	move_and_slide()
