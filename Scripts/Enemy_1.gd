extends KinematicBody2D

export var limit = 350
export var score = 10
export var speed = 2.0
export var move_probability = 0.50
export var fire_probability = 0.3

onready var enemy_laser = load("res://Scenes/Enemy Laser.tscn")

var ready = false

var new_position = Vector2(0,0)

func get_new_position():
	var VP = get_viewport_rect().size
	new_position.x = min(randi() % int(VP.x), int(VP.x) - limit)
	new_position.y = min(randi() % int(VP.y), int(VP.y) - limit)
	check_position(new_position.x,new_position.y)
	$Tween.interpolate_property(self, "position", position, new_position, speed, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	ready = true

func check_position(x,y):
	var VP = get_viewport_rect().size
	if x <= - 497:
		x = - 497
	if x >= VP.x - 530:
		x = VP.x - 530
	if y <= -660:
		y = -660
	if y >= VP.y - 720:
		y = VP.y - 720

func die():
	queue_free()

func _ready():
	randomize()
	get_new_position()

func _physics_process(delta):
	if ready:
		$Tween.start()
		ready = false

func _on_Timer_timeout():
	if randf() < move_probability:
		get_new_position()
	if randf() < fire_probability:
		var b = enemy_laser.instance()
		b.position = position
		b.position.y -= 80
		b.position.x += 237
		get_node("/root/Game/Enemy Bullets").add_child(b)
