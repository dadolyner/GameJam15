extends Node

var score: int = 0
var current_speaker: CharacterBody2D
var what_is_being_said: Array[String]
var only_one_tutorial_message: bool = false

const lines_for_coin_tip: Array[String] = [
	"Maybe I should collect them in the correct order..."
]

const lines_for_tutorial_p1_start: Array[String] = [
	"Close speech bubbles by pressing 'E' or 'CTRL'"
]
const lines_for_tutorial_p2_start: Array[String] = [
	"Close speech bubbles by pressing 'CTRL' or 'E'"
]
const lines_for_tutorial_kiwi: Array[String] = [
	"Its not going to be so easy in the real game!"
]

func _ready() -> void:
	Signals.triggers_chat_coin_puzzle.connect(_coin_puzzle_fail)
	Signals.triggers_tutorial_p1.connect(_tutorial_start_p1)
	Signals.triggers_tutorial_p2.connect(_tutorial_start_p2)
	Signals.triggers_tutorial_kiwi.connect(_tutorial_kiwi)

func _process(_delta) -> void:
	if current_speaker != null:
		DialogManager.update_position(current_speaker.position)

func _coin_puzzle_fail(character: CharacterBody2D) -> void:
	DialogManager.start_dialog(character.position, lines_for_coin_tip)
	current_speaker = character

func _tutorial_start_p1(character: CharacterBody2D) -> void:
	DialogManager.start_dialog(character.position, lines_for_tutorial_p1_start)


func _tutorial_start_p2(character: CharacterBody2D) -> void:
	DialogManager.start_dialog(character.position, lines_for_tutorial_p2_start)
	current_speaker = character
	
func _tutorial_kiwi(character: CharacterBody2D) -> void:
	if not only_one_tutorial_message:
		DialogManager.start_dialog(character.position, lines_for_tutorial_kiwi)
		current_speaker=character
		only_one_tutorial_message = true

func add_points(added_score: int) -> void:
	score = score + added_score
	
func reset_points() -> void:
	score = 0

func get_points() -> String:
	return str(score)

func get_speaker() -> CharacterBody2D:
	return current_speaker

func set_speaker(speaker: CharacterBody2D) -> void:
	current_speaker = speaker
