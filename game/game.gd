extends Control

@onready var background: Control = $Background
@onready var player_1_score_digit_0: Sprite2D = $player_1_score_digit_0
@onready var player_1_score_digit_1: Sprite2D = $player_1_score_digit_1
@onready var player_2_score_digit_0: Sprite2D = $player_2_score_digit_0
@onready var player_2_score_digit_1: Sprite2D = $player_2_score_digit_1
@onready var menu_button: Button = $menu_button

@onready var digits: Array[Resource] = [
	preload("res://game/number_0.png"),
	preload("res://game/number_1.png"),
	preload("res://game/number_2.png"),
	preload("res://game/number_3.png"),
	preload("res://game/number_4.png"),
	preload("res://game/number_5.png"),
	preload("res://game/number_6.png"),
	preload("res://game/number_7.png"),
	preload("res://game/number_8.png"),
	preload("res://game/number_9.png")
]

func _ready() -> void:
	menu_button.connect("button_down", on_menu_button_pressed)
	background.update(3)
	randomize()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://menu/menu.tscn")

func update_score(id, score) -> void:
	var score_string = "%02d" % score

	if   id == 0:
		player_1_score_digit_0.texture = digits[int(score_string[0])]
		player_1_score_digit_1.texture = digits[int(score_string[1])]
	elif id == 1:
		player_2_score_digit_0.texture = digits[int(score_string[0])]
		player_2_score_digit_1.texture = digits[int(score_string[1])]

func on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")
