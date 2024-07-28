extends Area2D
enum CollectableType { LIGHT, SHADOW }
enum CollectableSprite { PINEAPPLE, APPLE, CHERRY, KIWI, ORANGE, MELON, STRAWBERRY }

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_sound: AudioStreamPlayer = $PickupSound

@export var collectable_type: CollectableType
@export var collectable_sprite: CollectableSprite
@export var points: int

var is_collected: bool = false

func set_collectable_sprite() -> String:
	match collectable_type:
		0: match collectable_sprite:
			0: return "light_pineapple"
			1: return "light_apple"
			2: return "light_cherry"
			3: return "light_kiwi"
			4: return "light_orange"
			5: return "light_melon"
			6: return "light_strawberry"
			_:
				return ""
		1: match collectable_sprite:
			0: return "shadow_pineapple"
			1: return "shadow_apple"
			2: return "shadow_cherry"
			3: return "shadow_kiwi"
			4: return "shadow_orange"
			5: return "shadow_melon"
			6: return "shadow_strawberry"
			_:
				return ""
		_:
			return ""

func _ready() -> void:
	var animation = set_collectable_sprite()
	animated_sprite_2d.play(animation)

func _on_body_entered(_body) -> void:
	if is_collected:
		return

	is_collected = true
	GameManager.add_points(points)
	animated_sprite_2d.play("collected")
	pickup_sound.play()
	var timeout = pickup_sound.stream.get_length()
	await get_tree().create_timer(timeout).timeout
	self.queue_free()
