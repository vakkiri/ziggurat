extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.get_node("Camera2D").limit_bottom = 128
	$Player.get_node("Camera2D").limit_right = 128
	$Player.get_node("Camera2D").limit_left = 0
	$Player.get_node("Camera2D").limit_top = 0
	$CanvasLayer.get_node("TextureRect").visible = false


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$Controls.get_node("Controls").visible = !$Controls.get_node("Controls").visible
