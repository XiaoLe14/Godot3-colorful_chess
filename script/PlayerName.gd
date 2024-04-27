extends LineEdit





func _on_PlayerName_mouse_entered():
	$AnimationPlayer.playback_speed = 1.0
	$AnimationPlayer.play("playername")


func _on_PlayerName_mouse_exited():
	$AnimationPlayer.playback_speed = -1.0
	$AnimationPlayer.play("playername")
