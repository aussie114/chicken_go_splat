extends Area2D

const CAR = preload("res://car/car.tscn")
@onready var sprite: Sprite2D = $sprite

@export var direction: int
@export var speed: int
var speed_modifier: int
var lead_car: bool = true

func _ready() -> void:
    if lead_car:
        for i in range(1, Global.difficulty + 1):
            var new_car = CAR.instantiate()
            new_car.position.x -= 30 * i
            new_car.lead_car = false
            add_child(new_car)

func _physics_process(delta: float) -> void:
    position.x += (speed + speed_modifier) * direction * delta

    if direction == -1 and position.x <= -9:
        speed_modifier = randi_range(0,50)
        position.x = 387

    if direction == 1 and position.x >= 329:
        speed_modifier = randi_range(0,50)
        position.x = -69
