extends Node2D
# summary:
#things to work on:
# implement animations
# implement sound effects/music
# allow a random player to "serve" the ball on their side

#things that are working:
# pause menu
# main menu

#preloading
var pause = load("res://Scenes/pause_menu.tscn")
var start_game_screen = load("res://start_game_layer.tscn")

var player_points = 0
var enemy_points = 0
var playerTurn = 1

@onready var enemy_paddle = $EnemyPaddle
@onready var player_paddle = $Paddle
@onready var ball = $Ball
@onready var UI = $UI

@export var WINNING_SCORE = 1

#updates enemy score, make the left player the server,
#and reset the round
func enemy_scored():
	enemy_points += 1
	UI.update_enemy_points(enemy_points)
	#wait until space bar is entered(will do later)
	reset_game_state()
	if enemy_points == WINNING_SCORE:
		pass

#updates player score, make the right player the server,
#and reset the round
func player_scored():
	player_points += 1
	UI.update_player_point(player_points)
	#wait until space bar is entered (will do later)
	reset_game_state()
	if player_points == WINNING_SCORE:
		pass

func reset_game_state():
	#reset paddle x and y location
	enemy_paddle.global_position.y = 0
	enemy_paddle.global_position.x = 1000
	player_paddle.global_position.y = 0
	player_paddle.global_position.x = -1000
	
	#calculate turn and display on game start label
	#wait until any button is pressed
	randomize() 
	var randomChange = randi() % 2
	await UI.update_player_turn()
	
	ball.velocity = Vector2.ZERO
	enemy_paddle.linear_velocity = Vector2.ZERO
	player_paddle.linear_velocity = Vector2.ZERO
	
	#reset the ball's position based on turn
	ball.global_position = Vector2.ZERO
	ball.start_ball()

#function for pause menu
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pauseInstance = pause.instantiate()
		add_child(pauseInstance)
