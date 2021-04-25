extends Node2D

var flashing = true
var started = false
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	started = true


func _process(delta):
	if started:
		time += delta
