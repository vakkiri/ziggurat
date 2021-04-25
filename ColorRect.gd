extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	margin_right = margin_left + (20 * (get_parent().get_parent().get_parent().get_node("Player").health / 100.0))
