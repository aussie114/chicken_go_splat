extends Control

var menu_position = 0
@onready var cursor: Label = $Background/cursor
@onready var menu_text: Label = $Background/menu_text
@onready var game: Resource = preload("res://game/game.tscn")
@onready var background: Control = $Background

@onready var start_button: Button = $start_button
@onready var diff_button: Button = $diff_button
@onready var gore_button: Button = $gore_button

var difficulty: int = 0
var gore: int = 1

func _ready() -> void:
	start_button.connect("button_down", on_start_button_pressed)
	diff_button.connect("button_down", on_diff_button_pressed)
	gore_button.connect("button_down", on_gore_button_pressed)
	background.update(Global.difficulty)
	draw_menu()

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if   event.keycode == KEY_DOWN:
			menu_position += 1
		elif event.keycode == KEY_UP:
			menu_position -= 1

		elif event.keycode == KEY_RIGHT or event.keycode == KEY_ENTER:
			match menu_position:
				0:
					get_tree().change_scene_to_file("res://game/game.tscn")
				1:
					Global.update_difficulty(1)
					background.update(Global.difficulty)
				2:
					Global.update_gore()

		elif event.keycode == KEY_LEFT:
			match  menu_position:
				1:
					Global.update_difficulty(-1)
					background.update(Global.difficulty)
				2:
					Global.update_gore()

	if  menu_position > 2:
		menu_position = 0
	elif menu_position < 0:
		menu_position = 2

	draw_menu()


func draw_menu() -> void:
	menu_text.text = """Start
					Difficulty < %s >
					Gore      < %s >
					""" % [Global.difficulties[Global.difficulty], Global.gores[int(Global.gore)]]
	cursor.position.y = 23 + 15 * menu_position

func on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/game.tscn")

func on_diff_button_pressed() -> void:
	menu_position = 1
	Global.update_difficulty(1)
	background.update(Global.difficulty)
	draw_menu()

func on_gore_button_pressed() -> void:
	menu_position = 2
	Global.update_gore()
	draw_menu()
