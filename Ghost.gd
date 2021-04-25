extends AnimatedSprite


var startx
var starty


# Called when the node enters the scene tree for the first time.
func _ready():
	startx = position.x
	starty = position.y
	animation = "run"


func _process(delta):
	if animation != "ending":
		var player = get_parent().get_node("Player")
		position.x = startx + (startx - player.position.x)
		position.y = starty - (starty - player.position.y)
		animation = player.get_node("AnimatedSprite").animation
		frame = player.get_node("AnimatedSprite").frame


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.get_node("AnimatedSprite").visible = false
		body.ending = true
		animation = "ending"
		frame = 0


func _on_Ghost_animation_finished():
	if animation == "ending":
		get_tree().change_scene("res://End.tscn")
