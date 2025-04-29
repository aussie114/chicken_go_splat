extends Area2D

# universal vars
var speed: int = 15
var acceleration: int = 0
var max_acceleration: int = 5
var dead: bool = false
var score: int = 0

# unique vars
var id: int
var up_key: String
var down_key: String

var top_box: Rect2i
var mid_box: Rect2i
var bot_box: Rect2i

@onready var game = get_node("/root/game")
@onready var sprite: Sprite2D = $sprite
@onready var sprite_frames: Array[Resource] = [
	load("res://players/player/walk_frame_0.png"),
	load("res://players/player/walk_frame_1.png"),
	load("res://players/player/death_frame_0.png"),
	load("res://players/player/death_frame_1.png"),
	load("res://players/player/death_frame_2.png"),
	load("res://players/player/death_frame_3.png")
]
@onready var timer: Timer = $Timer
@onready var explosion_sound = $explosion_sound
@onready var goal_sound = $goal_sound
var tick: float = 0

func _ready() -> void:
	connect("area_entered", on_collision)
	timer.connect("timeout", on_timer_timeout)

func move_up() -> void:
	sprite.texture = sprite_frames[int(tick) % 2]
	if acceleration < max_acceleration:
		acceleration += 1

func move_down() -> void:
		sprite.texture = sprite_frames[int(tick) % 2]
		if acceleration > -max_acceleration:
			acceleration -= 1

func input_handing() -> void:

	if position.y <= 5 or position.y >= 176:
		acceleration = 0
		return
	var mouse_position = get_global_mouse_position()
	if   Input.is_action_pressed(up_key) \
	or Input.is_action_pressed("mouse_left") and top_box.has_point(mouse_position)\
	or Input.is_action_pressed("mouse_left") and mid_box.has_point(mouse_position) and mouse_position.y + 2 < position.y:
		move_up()

	elif Input.is_action_pressed(down_key) \
	or Input.is_action_pressed("mouse_left") and mid_box.has_point(mouse_position) and mouse_position.y - 2 > position.y \
	or Input.is_action_pressed("mouse_left") and bot_box.has_point(mouse_position):
		move_down()

	else:
		acceleration = 0
		sprite.texture = sprite_frames[0]


func _process(delta: float) -> void:
	tick += delta * 8

	if dead:
		return

	input_handing()

	position.y -= acceleration * speed * delta

	if position.y <= 14:
		on_goal()

	if position.y >= 176:
		position.y += -1 * speed * delta

func on_goal():
		if !goal_sound.is_playing():
			goal_sound.play()
		if score < 99:
			score += 1
		game.update_score(id, score)
		position.y = 184

func on_collision(_body):
	if dead:
		return
	if !explosion_sound.is_playing():
		explosion_sound.play()
	dead = true
	if Global.gore:
		sprite.texture = sprite_frames[randi_range(2,4)]
	else:
		sprite.texture = sprite_frames[5]
	timer.start()

func on_timer_timeout():
	sprite.texture = sprite_frames[0]
	dead = false
	position.y = 184
