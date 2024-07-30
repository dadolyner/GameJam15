extends CharacterBody2D
enum PlayerSprite {LIGHT, SHADOW}
enum BulletSprite {LIGHT, SHADOW}
enum PlayerIndex {PLAYER_ONE, PLAYER_TWO}

@onready var player: CharacterBody2D = $"."
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var throw_sound: AudioStreamPlayer = $ThrowSound
@onready var teleport_sound: AudioStreamPlayer = $TeleportSound
@onready var marker_2d: Marker2D = $Marker2D
@onready var timer: Timer = $Timer
@onready var player_indicatior: Label = $PlayerIndicatior

@export var player_index: PlayerIndex
@export var player_sprite: PlayerSprite
@export var controls: PlayerControls = null
@export var bullet_sprite: BulletSprite
@export var allowed_to_shoot: bool = false
@export var time_between_shots: float = 1.0

const SPEED: float = 100.0
const JUMP_VELOCITY: float = -300.0
const MAX_JUMPS: int = 2
const GRAVITY: float = 900.0
const FALL_GRAVITY: float = 1300.0
const INITIAL_SCALE: float = 1.0
const BULLET_NODE = preload("res://src/scenes/Player/bullet.tscn")

var jump_count: int = 0
var platform_velocity: float = 0.0
var bullet_direction: Vector2 = Vector2(1, 0)
var can_shoot: bool = true
var current_player_sprite: String

var can_shift = false
var shift_delay = 0.2
var shift_timer = 0.0

func _ready() -> void:
	set_player_sprite()

func _physics_process(delta) -> void:	
	if not is_on_floor():
		velocity.y += get_gravity(velocity) * delta
		
	# Handle player swapping
	if Globals.current_player != player_index:
		player_indicatior.visible = false
		if is_on_floor():
			velocity.x = 0
			velocity.y = 0
			animated_sprite.play(current_player_sprite + "_idle")
		else:
			animated_sprite.play(current_player_sprite + "_fall")
		return move_and_slide()
		
	var direction = Input.get_axis(controls.move_left, controls.move_right)
	var scaled_velocity = get_scaled_velocity(player.scale)
	player_indicatior.visible = true
	
	if is_on_floor():
		jump_count = 0
		
	if Input.is_action_just_released(controls.jump) and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4
		
	if (Input.is_action_just_pressed(controls.jump) && jump_count < MAX_JUMPS):
		jump()
		
	if (Input.is_action_just_pressed(controls.drop) && is_on_floor()):
		drop()
		
	if Input.is_action_just_pressed(controls.shoot):
		shoot()
		
	if Input.is_action_just_pressed(controls.shift) and can_shift:
		Globals._shift_players()
		can_shift = false
		shift_timer = shift_delay
		
		if (!teleport_sound.is_playing()):
			teleport_sound.pitch_scale = randf_range(0.8, 1.2)
			teleport_sound.play()
		
	play_player_animation(direction)
	
	if direction:
		velocity.x = direction * scaled_velocity * SPEED
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0.0, scaled_velocity * SPEED)
	
	platform_velocity = get_platform_velocity().x
	update_shift_timer(delta)
	set_bullet_direction(direction)
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

# Set player sprite
func set_player_sprite():
	match player_sprite:
		0: current_player_sprite = "light"
		1: current_player_sprite = "shadow"

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
			animated_sprite.play(current_player_sprite + "_idle")
		else:
			animated_sprite.play(current_player_sprite + "_run")
	else:
		if velocity.y > 0.0:
			animated_sprite.play(current_player_sprite + "_fall")
		else:
			if jump_count > 1:
				animated_sprite.play(current_player_sprite + "_double_jump")
			else:
				animated_sprite.play(current_player_sprite + "_jump")

# Shoot mekanik
func shoot() -> void:
	if !can_shoot or !allowed_to_shoot:
		return
	
	can_shoot = false
	timer.start(time_between_shots)
	var bullet = BULLET_NODE.instantiate()
	bullet.set_direction(bullet_direction)
	bullet.global_position = marker_2d.global_position
	get_parent().add_child(bullet)
	bullet.set_sprite(bullet_sprite)
	
	if (!throw_sound.is_playing()):
		throw_sound.pitch_scale = randf_range(0.6, 2)
		throw_sound.play()

func set_bullet_direction(direction: float) -> void:
	if direction > 0.0:
		bullet_direction = Vector2(1, 0)
	elif direction < 0.0:
		bullet_direction = Vector2(-1, 0)

func _on_timer_timeout() -> void:
	can_shoot = true

func update_shift_timer(delta: float) -> void:
	if not can_shift:
		shift_timer -= delta
		if shift_timer <= 0:
			can_shift = true
			shift_timer = 0
