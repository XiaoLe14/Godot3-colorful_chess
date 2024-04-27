extends LineEdit




func _on_Port_mouse_entered():
	$AnimationPlayer.playback_speed = 1.0
	$AnimationPlayer.play("port")


func _on_Port_mouse_exited():
	$AnimationPlayer.playback_speed = -1.0
	$AnimationPlayer.play("port")
