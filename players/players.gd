extends Node2D

@onready var player_1: Area2D = $Player_1
@onready var player_2: Area2D = $Player_2

func _ready() -> void:
	player_1.id = 0
	player_1.up_key = "w"
	player_1.down_key = "s"
	player_1.top_box = Rect2(0,   0, 160,  20)
	player_1.mid_box = Rect2(0,  20, 160, 171)
	player_1.bot_box = Rect2(0, 171, 160, 180)

	player_2.id = 1
	player_2.up_key = "ui_up"
	player_2.down_key = "ui_down"
	player_2.top_box = Rect2(160,   0, 320,  20)
	player_2.mid_box = Rect2(160,  20, 320, 171)
	player_2.bot_box = Rect2(160, 171, 320, 180)
