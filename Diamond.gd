extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.diamonds += 1
		$"/root/GetDiamondSound".play()
		queue_free()
		# lol hahaha wow im good at coding
		if body.diamonds == 1:
			get_parent().get_node("CanvasLayer2").get_node("Light1").frame = 1
		if body.diamonds == 2:
			get_parent().get_node("CanvasLayer2").get_node("Light2").frame = 1
		if body.diamonds == 3:
			get_parent().get_node("CanvasLayer2").get_node("Light3").frame = 1
		if body.diamonds == 4:
			get_parent().get_node("CanvasLayer2").get_node("Light4").frame = 1
		if body.diamonds == 5:
			get_parent().get_node("CanvasLayer2").get_node("Light5").frame = 1
