extends AnimatedSprite

var phase = 0
var dir = "RIGHT"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if dir == "RIGHT":
		phase += delta * 5
		
		if phase >= PI/2:
			dir = "LEFT"
	elif dir == "LEFT":
		phase -= delta * 5
		if phase <= -PI/2:
			dir = "RIGHT"
			
	scale.x = sin(phase * 0.9) * 0.5 + 1
	scale.y = cos(phase) * 0.5 + 1
	
	rotate(sin(phase) * 0.01)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.has_key = true
		$"/root/GetKeySound".play()
		queue_free()
