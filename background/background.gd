extends Control

@onready var backgrounds: Array[Resource] = [
	load("res://background/background_0.png"),
	load("res://background/background_1.png"),
	load("res://background/background_2.png"),
	load("res://background/background_3.png")
]

@onready var sprite: Sprite2D = $sprite

func update(index: int):
	sprite.texture = backgrounds[index]
