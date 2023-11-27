extends Control

@onready var WinnerLabel = $WinnerLabel
@onready var WinnerBackground = $WinnerLabel/ColorRect
@onready var QuitButton = $Quit/QuitButton
@onready var RematchButton = $Rematch/RematchButton
var WinText = " Won"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Function that runs when the winscreen is visible
func DisplayWinner(Winner):
	WinnerLabel.text = Winner + WinText
	if(Winner == "Scare E Clown"):
		WinnerBackground.set_color(Color.hex(0xf27476ff))
		WinnerLabel.label_settings.font_color = Color.hex(0x9f9f9fff)
	else:
		WinnerBackground.set_color(Color.hex(0xa2d2ffff))
