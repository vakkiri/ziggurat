extends ParallaxLayer


export var speed = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	motion_offset.x += speed * delta
