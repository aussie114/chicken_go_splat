extends Node2D

@onready var car: Resource = preload("res://row/row.tscn")
var colours: Array[int] = [
	0x9c2020FF,
	0xb4e490FF,
	0x646410FF,
	0xe08888FF,
	0x1c209cFF,
	0x985c28FF,
	0x6874d0FF,
	0xb03c3cFF,
	0x84b468FF,
	0xd0d050FF
]

func add_row(star_position: Vector2, Colour: int, direction: int, speed: int) -> void:
	var new_row = car.instantiate()
	new_row.position = star_position
	new_row.car_colour = Colour
	new_row.direction = direction
	new_row.speed = speed
	add_child(new_row)

func _ready() -> void:
	for i in range(5):
		add_row(Vector2(311,27+15*i), colours[i], -1, 90+i*50)

	for i in range(5):
		add_row(Vector2(9,104+15*i), colours[5+i], 1, 290-i*50)
