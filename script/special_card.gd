extends TextureButton
var up = false
signal special_card_click(id)
signal move_card_click(id)
var mode = true
var dissolve = 1
var start_pos = Vector2.ZERO
var to_pos = Vector2.ZERO
func _pressed():
	material.set_shader_param("dissolve_value",dissolve)
func _on_TextureButton_mouse_entered():
	_on_entered()
func _on_special_card_pressed():
	_on_click()

func _on_TextureButton_mouse_exited():
	_on_exited()
func _on_pressed():
	_on_click()
func _on_entered():
	start_pos = Vector2(rect_position.x,0)
	to_pos = Vector2(rect_position.x,-50)
	$Tween.interpolate_property($".","rect_position",start_pos,to_pos,0.1)
	$Tween.start()
func _on_exited():
	var leave_sp = Vector2(rect_position.x,-50)
	var leave_tp = Vector2(rect_position.x,0)
	$Tween.interpolate_property($".","rect_position",leave_sp,leave_tp,0.1)
	$Tween.start()

func _on_click():
	if mode:
		emit_signal("special_card_click",texture_normal.load_path)

