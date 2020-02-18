extends KinematicBody2D

export var health = 100
export var score = 0
export var margin = 5
export var y_range = 150
export var acceleration = 0.15

var velocity = Vector2(0,0)

onready var VP = get_viewport_rect().size

onready var Laser = load("res://Scenes/Laser.tscn")

signal health_changed
signal score_changed

func change_health(h):
	health += h
	emit_signal("health_changed")
	if health <= 0:
		die()
		
func change_score(s):
	score += s
	emit_signal("score_changed")
		
func die():
	queue_free()
	get_tree().change_scene("res://Scenes/Game Over.tscn")

func _ready():
	emit_signal("health_changed")
	emit_signal("score_changed")

func _physics_process(delta):
	if Input.is_action_pressed("Fire"):
		var b = Laser.instance()
		b.position = position
		b.position.y += 92
		b.position.x += 607
		get_node("/root/Game/Bullets").fire(b)
	
	if Input.is_action_pressed("Left"):
		velocity.x -= acceleration
	if Input.is_action_pressed("Right"):
		velocity.x += acceleration	
	if Input.is_action_pressed("Up"):
		velocity.y -= acceleration
	if Input.is_action_pressed("Down"):
		velocity.y += acceleration
	
	if position.x < - 338:
		velocity.x = 0
		position.x = - 338
	if position.x > VP.x - 690:
		velocity.x = 0
		position.x = VP.x - 690
	if position.y < -660:
		velocity.y = 0
		position.y = -660
	if position.y > VP.y - 720:
		velocity.y = 0
		position.y = VP.y - 720
		
		
	var collision = move_and_collide(velocity)
