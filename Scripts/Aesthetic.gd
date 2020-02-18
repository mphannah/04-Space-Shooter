extends Node2D

export var probability = 0.3

onready var small_star = load("res://Scenes/Small Star.tscn")

func _ready():
	randomize()

func _on_Timer_timeout():
	if randf() < probability:
		var s = small_star.instance()
		add_child(s)
