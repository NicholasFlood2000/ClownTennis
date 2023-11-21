extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true

func _on_resume_button_pressed():
	get_tree().paused = false
	queue_free()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
