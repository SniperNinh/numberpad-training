extends Button

@export var corresponding_key : String = "nump_1"
@export var key_value : String = "1"
@export var key_activated_color : Color = Color(0.117, 0.117, 0.117)

@onready var key_activated_style_box = StyleBoxFlat.new()
@onready var game_manager = get_node("res://GameManager.gd")

func _ready() -> void:
	key_activated_style_box.bg_color = key_activated_color

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed(corresponding_key):
		press_key()

func _pressed() -> void:
	press_key()

func press_key() -> void:
	add_theme_stylebox_override("normal", key_activated_style_box)
	game_manager.on_key_pressed(key_value)
