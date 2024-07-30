extends CharacterBody2D

@onready var raycast_left: RayCast2D = $Raycasts/RaycastLeft
@onready var raycast_right: RayCast2D = $Raycasts/RaycastRight
@onready var raycast_front: RayCast2D = $Raycasts/RaycastFront
@onready var raycast_back: RayCast2D = $Raycasts/RaycastBack
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: float = 60.0

var direction: int = 1

func _physics_process(delta) -> void:
		
	if raycast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	
	if raycast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	velocity.x = direction * SPEED
	move_and_slide()
