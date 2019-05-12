extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const MOVE_SPEED = 300

onready var raycast = $RayCast2D
	
# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)
	pass # Replace with function body.

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):		
		move_vec.x += 1

	move_vec = move_vec.normalized()
	
	move_and_collide(move_vec * MOVE_SPEED * delta)

	# var look_vec = get_global_mouse_position() - global_position 
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("shoot"):
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("kill"):
			coll.kill()

func kill():
	get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
