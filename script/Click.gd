extends Node2D


func _ready():
	for ia in get_children():
		ia.emitting = true
