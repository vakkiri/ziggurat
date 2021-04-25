extends AnimatedSprite


var startx
var starty


# Called when the node enters the scene tree for the first time.
func _ready():
	startx = position.x
	starty = position.y


func _process(delta):
	var player = get_parent().get_node("Player")
	position.x = startx + (startx - player.position.x)
	position.y = starty - (starty - player.position.y)
	animation = player.get_node("AnimatedSprite").animation
	frame = player.get_node("AnimatedSprite").frame
