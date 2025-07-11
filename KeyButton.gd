class_name KeyButton extends Button

@export var corresponding_key : String = "nump_1"
@export var key_activated_color : Color = Color(0.117, 0.117, 0.117)

@onready var key_activated_style_box = StyleBoxFlat.new()

func _ready() -> void:
	key_activated_style_box.bg_color = key_activated_color

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed(corresponding_key):
		add_theme_stylebox_override("normal", key_activated_style_box)
	elif has_theme_stylebox_override("normal"):
		remove_theme_stylebox_override("normal")
