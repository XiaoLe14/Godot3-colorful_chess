extends LineEdit



func _on_TextEdit_mouse_entered():
	$AnimationPlayer.playback_speed = 1.0
	$AnimationPlayer.play("chat")


func _on_TextEdit_mouse_exited():
	$AnimationPlayer.playback_speed = -1.0
	$AnimationPlayer.play("chat")
