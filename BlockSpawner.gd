extends Node2D

const BLOCK = preload("res://GlitchBlock.tscn")

var cd = 0.75
var timer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	timer -= delta
	if timer <= 0:
		timer += cd + rand_range(0, 0.25)
		if rand_range(0, 1) < 0.4:
			var block = BLOCK.instance()
			block.position.x = position.x
			block.position.y = position.y
			get_parent().add_child(block)
