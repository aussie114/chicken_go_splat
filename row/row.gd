extends Node2D

@onready var car: Resource = preload("res://car/car.tscn")
var car_colour = 0
var direction = 0
var speed = 0
var speed_modifier = 10

func _ready() -> void:
	for i in range(Global.difficulty+1):
		var new_car = car.instantiate()
		new_car.position.x = (30 * direction) * i
		new_car.get_node("sprite").modulate = car_colour
		if direction == 1:
			new_car.get_node("sprite").flip_h = true
		add_child(new_car)

func _process(delta: float) -> void:
	position.x += (speed + speed_modifier) * delta * direction
	if   position.x < -8 and direction == -1:
		position.x = 388+randi_range(10,20)
		speed_modifier = randi_range(0,50)

	elif position.x > 328 and direction == 1:
		position.x = -68-randi_range(10,20)
		speed_modifier = randi_range(0,50)
