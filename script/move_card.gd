extends TextureButton
signal move_card_click(id)
signal special_card_click(id)
var mode = true
var dissolve = 1
var start_pos = Vector2.ZERO
var to_pos = Vector2.ZERO
var uped = false
var clicked = false

func _on_TextureButton_mouse_entered():
	if not disabled:
		_on_entered()
func _on_move_card_pressed():
	if uped:
		if not disabled:
			_on_exited()
		uped = false
	else:
		if not disabled:
			_on_entered()
		uped = true
	if clicked == false:
		clicked = true
		$Timer.start()
	else:
		_on_click()
		clicked = false

func _on_TextureButton_mouse_exited():
	if not disabled:
		_on_exited()
func _on_entered():
	uped = true
	start_pos = Vector2(rect_position.x,0)
	to_pos = Vector2(rect_position.x,-50)
	$Tween.interpolate_property($".","rect_position",start_pos,to_pos,0.1)
	$Tween2.interpolate_property($".","rect_scale",Vector2(1.0,1.0),Vector2(1.2,1.2),0.1,Tween.TRANS_BACK,Tween.EASE_OUT)
	$Tween.start()
	$Tween2.start()
func _on_exited():
	uped = false
	var leave_sp = Vector2(rect_position.x,-50)
	var leave_tp = Vector2(rect_position.x,0)
	$Tween.interpolate_property($".","rect_position",leave_sp,leave_tp,0.1)
	$Tween.start()
	$Tween2.interpolate_property($".","rect_scale",Vector2(1.2,1.2),Vector2(1.0,1.0),0.1,Tween.TRANS_BACK,Tween.EASE_OUT)
	$Tween2.start()

func _on_click():
	if mode:
		emit_signal("move_card_click",texture_normal.load_path,name)
		
func _on_Timer_timeout():
	clicked = false
func create_and_add_tween() -> Tween:
	var tween = Tween.new()
	add_child(tween)
	return tween
