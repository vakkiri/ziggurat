extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if $"/root/IntroMusic".playing:
		$"/root/IntroMusic".stop()
	if not $"/root/Song1".playing:
		$"/root/Song1".play()
	$Player.get_node("Camera2D").limit_bottom = 144
	
	$"/root/Settings".started = true


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$Controls.get_node("Controls").visible = !$Controls.get_node("Controls").visible
