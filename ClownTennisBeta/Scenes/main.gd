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

@onready var WinScreen = $Menu
@onready var RematchButton = $Menu/Rematch/RematchButton
@onready var enemy_paddle = $EnemyPaddle
@onready var player_paddle = $Paddle
@onready var ball = $Ball
@onready var UI = $UI
@onready var Audio = $AudioStreamPlayer

@onready var Hit = $Audio/BallHit
@onready var GameTheme = $Audio/GameTheme
@onready var HapEScore = $Audio/HapEScore
@onready var HapEFail = $Audio/HapEFail
@onready var HapEVictory = $Audio/HapEVictory
@onready var ScareEScore = $Audio/ScareEScore
@onready var ScareEFail = $Audio/ScareEFail
@onready var ScareEVictory = $Audio/ScareEVictory


@export var DEFAULT_WINNING_SCORE = 2
@export var WINNING_SCORE = DEFAULT_WINNING_SCORE

#updates enemy score, make the left player the server,
#and reset the round
func enemy_scored():
	enemy_points += 1
	
	if(((player_points == (WINNING_SCORE-1)) and (enemy_points == (WINNING_SCORE-1)))):
		WINNING_SCORE += 1
		print(WINNING_SCORE)
	UI.update_enemy_points(enemy_points)
	#wait until space bar is entered(will do later)
	if ((enemy_points == WINNING_SCORE)):
		GameTheme.stop()
		HapEVictory.play()
		WinScreen.visible = true
		WinScreen.QuitButton.disabled = false
		WinScreen.RematchButton.disabled = false
		WinScreen.DisplayWinner("Hap E Clown")
	else:
		#wait until space bar is entered(will do later)
		if(ball.horizontalDirection == 1):
			HapEScore.play()
		else:
			ScareEFail.play()
		reset_game_state()
		

#updates player score, make the right player the server,
#and reset the round
func player_scored():
	player_points += 1
	
	if(((player_points == (WINNING_SCORE-1)) and (enemy_points == (WINNING_SCORE-1)))):
		WINNING_SCORE += 1
		print(WINNING_SCORE)
	UI.update_player_points(player_points)
	#wait until space bar is entered (will do later)
	if ((player_points == WINNING_SCORE)):
		GameTheme.stop()
		ScareEVictory.play()
		WinScreen.visible = true
		WinScreen.QuitButton.disabled = false
		WinScreen.RematchButton.disabled = false
		WinScreen.DisplayWinner("Scare E Clown")
	else:
		#wait until space bar is entered(will do later)
		if(ball.horizontalDirection == -1):
			ScareEScore.play()
		else:
			HapEFail.play()
		reset_game_state()

func reset_game_state():
	#reset paddle x and y location
	enemy_paddle.global_position.y = 0
	enemy_paddle.global_position.x = 1000
	player_paddle.global_position.y = 0
	player_paddle.global_position.x = -1000
	ball.horizontalDirection = ball.horizontalDirection * -1
	if not(WinScreen.visible):
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


func _on_rematch_button_pressed():
	enemy_points = 0
	player_points = 0
	UI.update_enemy_points(0)
	UI.update_player_points(0)
	WINNING_SCORE = DEFAULT_WINNING_SCORE
	GameTheme.play()
	ScareEVictory.stop()
	HapEVictory.stop()
	WinScreen.visible = false
	WinScreen.QuitButton.disabled = true
	WinScreen.RematchButton.disabled = true
	reset_game_state()
	pass # Replace with function body.
