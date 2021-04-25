extends CanvasLayer

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if time < 6:
		time += delta
	$TextureRect.margin_left -= 150 * delta
	$TextureRect2.margin_left += 150 * delta
