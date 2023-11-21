extends RigidBody2D
const SPEED = 500

@onready var ball 

#might add boolean that randomly decides who serves ball
func _ready():
	# find the ball in the scene
	ball = get_tree().get_first_node_in_group("ball")

func _physics_process(_delta):
	var movement = Vector2.ZERO
	if Input.is_action_pressed("player2_move_up"):
		movement = Vector2.UP
	elif Input.is_action_pressed("player2_move_down"):
		movement = Vector2.DOWN
	#add left and right, need to change code so that horizontal and 
	#vertical inputs are accepted at same time
	elif Input.is_action_pressed("player2_move_left"):
		movement = Vector2.LEFT
	elif Input.is_action_pressed("player2_move_right"):
		movement = Vector2.RIGHT
	linear_velocity = movement * SPEED;
	
