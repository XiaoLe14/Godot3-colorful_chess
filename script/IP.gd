extends LineEdit




func _on_IP_mouse_entered():
	$AnimationPlayer.playback_speed = 1.0
	$AnimationPlayer.play("ip")


func _on_IP_mouse_exited():
	$AnimationPlayer.playback_speed = -1.0
	$AnimationPlayer.play("ip")
