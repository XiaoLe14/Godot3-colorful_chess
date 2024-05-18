extends Node2D

var dx = 0
var dy = 0

func _process(delta):
	if not (dx == 0 or dy == 0):
		position = Vector2(40 * dx,40 * dy)
