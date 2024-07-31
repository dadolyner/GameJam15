extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon_timer: Timer = $WeaponTimer
@onready var swap_timer: Timer = $SwapTimer

@onready var throw_sound: AudioStreamPlayer = $ThrowSound
@onready var health: Label = $Health

@export var bullet_markers: Array[Marker2D]
@export var relm_markers: Array[Marker2D]

const GRAVITY: float = 900.0
const BULLET_NODE = preload("res://src/scenes/Boss/boss_bullet.tscn")

var bullet_direction: Vector2 = Vector2(-1, 0)
var direction: int = 1
var time_between_shots: float = 1.0
var time_between_swaps: float = 10.0
var current_realm: int = 0
var rng = RandomNumberGenerator.new()

var boss_health: int = 20

func _ready() -> void:
	weapon_timer.connect("timeout", Callable(self, "_on_weapon_timer_timeout"))
	swap_timer.connect("timeout", Callable(self, "_on_swap_timer_timeout"))
	weapon_timer.start(time_between_shots)
	swap_timer.start(time_between_swaps)

func _physics_process(delta) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	match current_realm:
		0: animated_sprite_2d.play("light_idle")
		1: animated_sprite_2d.play("shadow_idle")
	
	velocity.x = 0
	move_and_slide()
	
func _on_weapon_timer_timeout() -> void:
	shoot()
	
func _on_swap_timer_timeout() -> void:
	swap()

# Shoot mekanik
func shoot() -> void:
	var num_bullets = rng.randi_range(1, 3)
	for i in range(num_bullets):
		var bullet = BULLET_NODE.instantiate()
		var marker = rng.randi_range(0, len(bullet_markers) - 1)
		bullet.set_direction(bullet_direction)
		bullet.global_position = bullet_markers[marker].global_position
		get_parent().add_child(bullet)
		bullet.set_sprite(current_realm)
	
	if not throw_sound.is_playing():
		throw_sound.pitch_scale = rng.randf_range(0.6, 2)
		throw_sound.play()

func take_damage() -> void:
	boss_health -= 1
	health.text = str(boss_health)
	if boss_health <= 0:
		animated_sprite_2d.play("die")
		self.queue_free()

func swap():
	if current_realm == 0:
		current_realm = 1
	else:
		current_realm = 0
	
	self.position = relm_markers[current_realm].global_position
