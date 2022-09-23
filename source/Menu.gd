extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/startButton.grab_focus()


func _on_startButton_pressed() -> void:
	get_tree().change_scene("res://source/mainstage.tscn")


func _on_quitButton_pressed() -> void:
	get_tree().quit()
