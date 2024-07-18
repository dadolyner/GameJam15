extends Node2D

@export var coinCollection: Array[Area2D]

@onready var pickup_sound = $PickupSound
@onready var fail_sound = $FailSound

var isInOrder: bool = false
var tableIterator: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func pickup_coin(coin):
	if not isInOrder and coinCollection[tableIterator] == coinCollection[0] and coin == coinCollection[0]:
		isInOrder = true
		tableIterator += 1
		pickup_sound.play()
		coinCollection[0].set_collision_mask_value(2, 0)
		coinCollection[0].get_node("Sprite2D").play("explosion")

	else:
		var coins = coinCollection.slice(1, coinCollection.size())
		var found = false
		for coin_object in coins:
			if isInOrder and coinCollection[tableIterator] == coin_object and coin == coin_object:
				tableIterator += 1
				pickup_sound.play()
				coin_object.get_node("Sprite2D").play("explosion")
				coin_object.set_collision_mask_value(2, 0)
				found = true
				break
		if not found:
			reset_Coins()

			
func reset_Coins():
	for j in range(0,len(coinCollection)):
		coinCollection[j].visible = true
		coinCollection[j].set_collision_mask_value(2,1)
		coinCollection[j].get_node("Sprite2D").play("idle")
		isInOrder = false
		fail_sound.play()
		tableIterator = 0
