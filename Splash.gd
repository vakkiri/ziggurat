extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _input(event):
	if event is InputEventKey and event.pressed and event.scancode != KEY_ESCAPE:
		get_tree().change_scene("res://Area1.tscn")
		
		
# Called when the node enters the scene tree for the first time.
func _ready():
	if not $"/root/IntroMusic".playing:
		$"/root/IntroMusic".play()


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$Controls.visible = !$Controls.visible
