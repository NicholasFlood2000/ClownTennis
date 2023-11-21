extends CharacterBody2D

class_name Ball

@export var INITIAL_BALL_SPEED = 20

@export var speed_multiplier = 1.02

var ball_speed = INITIAL_BALL_SPEED
var horizontalDirection = 1

func _ready():
	start_ball()

func _physics_process(delta):
	var collision = move_and_collide(velocity * ball_speed * delta)
	
	if(collision):
	# change direction
		velocity =  velocity.bounce(collision.get_normal()) * speed_multiplier

func start_ball():
	#may need to make add parameters, with the first call of ball 
	#in _ready using default parameters
	randomize()
	var currentRandomSpin = [-1, 1][randi() % 2]
	if currentRandomSpin == 0:
		pass
	velocity.x = horizontalDirection * INITIAL_BALL_SPEED
	velocity.y = [-.8, .8][randi() % 2] * INITIAL_BALL_SPEED

