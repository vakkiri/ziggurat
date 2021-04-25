extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if not $"/root/Song1".playing:
		$"/root/Song1".play()
	$Player.get_node("Camera2D").limit_bottom = 144


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
