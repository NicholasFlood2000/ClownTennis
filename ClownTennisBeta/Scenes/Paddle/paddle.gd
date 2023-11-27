extends RigidBody2D

@export var speed = 500

func _physics_process(_delta):
	var movement = Vector2.ZERO
	if Input.is_action_pressed("player1_move_up"):
		movement = Vector2.UP
	elif Input.is_action_pressed("player1_move_down"):
		movement = Vector2.DOWN
	#add left and right, need to change code so that horizontal and 
	#vertical inputs are accepted at same time
	if Input.is_action_pressed("player1_move_left"):
		movement += Vector2.LEFT
	elif Input.is_action_pressed("player1_move_right"):
		movement += Vector2.RIGHT
	linear_velocity = movement * speed;


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
