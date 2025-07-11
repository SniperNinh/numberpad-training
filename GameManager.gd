extends Node

enum GameMode { addition, subtraction, multiplication, division }

@export var current_mode: GameMode = GameMode.addition
@onready var question_label = $TextContainer/QuestionLabel
@onready var input_label = $TextContainer/InputLabel
@onready var result_label = $TextContainer/ResultLabel

var number_a: int = 0
var number_b: int = 0
var user_input: String = ""

func _ready() -> void:
	generate_question()

func generate_question() -> void:
	number_a = randi() % 10 + 1
	number_b = randi() % 10 + 1
	user_input = ""
	update_display()

func update_display():
	match current_mode:
		GameMode.addition:
			question_label.text = "%d + %d =" % [number_a, number_b]
		GameMode.subtraction:
			question_label.text = "%d - %d =" % [number_a, number_b]
		GameMode.multiplication:
			question_label.text = "%d x %d =" % [number_a, number_b]
		GameMode.division:
			number_b = max(1, number_b)
			number_a = number_b * (randi() % 10 + 1)
			question_label.text = "%d ÷ %d =" % [number_a, number_b]
	input_label.text = user_input
	result_label.text = ""

func on_key_pressed(key: String):
	match key:
		"enter":
			check_answer()
		"backspace":
			if user_input.length() > 0:
				user_input = user_input.left(user_input.length() - 1)
		_:
			user_input += key
	input_label.text = user_input


func check_answer():
	var correct_answer = 0

	match current_mode:
		GameMode.addition:
			correct_answer = number_a + number_b
		GameMode.subtraction:
			correct_answer = number_a - number_b
		GameMode.multiplication:
			correct_answer = number_a * number_b
		GameMode.division:
			correct_answer = number_a / number_b
		
	if user_input.to_int() == correct_answer:
		result_label.text = "Correct!"
	else:
		result_label.text = "Try again!"

	await get_tree().create_timer(1.5).timeout
	generate_question()
