extends RigidBody2D

export var speed = 500
onready var Explostion = load("res://Scenes/Enemy Explosion.tscn")
onready var Player = get_node("/root/Game/Player")

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	var colliding = get_colliding_bodies()
	for c in colliding:
		var explosion = Explostion.instance()
		explosion.position = position
		explosion.position.y += 195
		explosion.position.x -= 15
		explosion.get_node("Sprite").playing = true
		get_node("/root/Game/Explosions").add_child(explosion)
		if c.get_parent().name == "Enemies":
			Player.change_score(c.score)
			c.die()
		queue_free()
	
	if position.y < -660:
		queue_free()

func _integrate_forces(state):
	state.set_linear_velocity(Vector2(0,-speed))
	state.set_angular_velocity(0)
