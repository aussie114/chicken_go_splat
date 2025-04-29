extends Area2D

const CAR = preload("res://car/car.tscn")

var direction: int
@export var speed: int
var speed_modifier: int

func _ready() -> void:
	if   position.y < 90:
		direction = -1
	elif position.y > 90:
		direction = 1

	for i in range(1,3):
		var new_car = CAR.instantiate()
		new_car.position.x -= 30 * i
		add_child(new_car)

func _physics_process(delta: float) -> void:
	position.x += (speed + speed_modifier) * direction * delta

	if direction == -1 and position.x <= -9:
		speed_modifier = randi_range(0,50)
		position.x = 387
