extends Node

var difficulty: int = 1
var gore: bool = true

var difficulties: Array[String] = [" easy ","medium"," hard "]
var gores: Array[String] = ["  off ", "  on  "]

func update_gore():
	gore = !gore

func update_difficulty(increment: int):
	difficulty += increment
	if   difficulty > 2:
		difficulty = 0
	elif difficulty < 0:
		difficulty = 2
