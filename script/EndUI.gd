extends Node2D


func _ready():
	pass
func start():
	yield(get_tree().create_timer(0.5), "timeout")
	$AnimationPlayer.play("start")
func create_and_add_tween() -> Tween:
	var tween = Tween.new()
	add_child(tween)
	return tween

	
