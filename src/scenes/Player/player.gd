extends CharacterBody2D

@onready var player: CharacterBody2D = $"."
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var jump_sound: AudioStreamPlayer = $JumpSound

@export var controls: PlayerControls = null

const SPEED: float = 100.0
const JUMP_VELOCITY: float = -300.0
const MAX_JUMPS: int = 4
const GRAVITY: float = 900.0
const FALL_GRAVITY: float = 1300.0
const INITIAL_SCALE: float = 1.0

var jump_count: int = 0
var platform_velocity: float = 0.0

func _physics_process(delta) -> void:
	var direction = Input.get_axis(controls.move_left, controls.move_right)
	var scaled_velocity = get_scaled_velocity(player.scale)
	
	if not is_on_floor():
		velocity.y += get_gravity(velocity) * delta
		
	if is_on_floor():
		jump_count = 0
		
	if Input.is_action_just_released(controls.jump) and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4
		
	if (Input.is_action_just_pressed(controls.jump) && jump_count < MAX_JUMPS):
		jump()
		
	if (Input.is_action_just_pressed(controls.drop) && is_on_floor()):
		drop()
		
	play_player_animation(direction)
	
	if direction:
		velocity.x = direction * scaled_velocity * SPEED
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0.0, scaled_velocity * SPEED)
	
	platform_velocity = get_platform_velocity().x
	move_and_slide()

# Non Linear gravity
func get_gravity(gravity_velocity: Vector2) -> float:
	if gravity_velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY
	
# Scale based velocity
func get_scaled_velocity(player_scale: Vector2) -> float:
	var scaled_velocity = INITIAL_SCALE / player_scale.x
	if scaled_velocity < INITIAL_SCALE:
		return scaled_velocity
	else:
		return INITIAL_SCALE

# Jump function
func jump() -> void:
	velocity.y = JUMP_VELOCITY
	velocity.x = platform_velocity
	jump_count += 1
		
	if (!jump_sound.is_playing()):
		jump_sound.pitch_scale = randf_range(0.8, 1)
		jump_sound.play()

# Drop funtion
func drop() -> void:
	position.y += 2

# Animation
func play_player_animation(direction: float) -> void:
	# Flip sprite handler
	if direction > 0.0:
		animated_sprite.flip_h = false
	elif direction < 0.0:
		animated_sprite.flip_h = true
	
	# Animation handler
	if is_on_floor():
		if direction == 0.0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y > 0.0:
			animated_sprite.play("fall")
		else:
			if jump_count > 1:
				animated_sprite.play("double_jump")
			else:
				animated_sprite.play("jump")
