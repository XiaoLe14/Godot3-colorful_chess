extends Node2D


func _ready():
	for ia in get_children():
		ia.emitting = true
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
