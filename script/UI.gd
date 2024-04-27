extends CanvasLayer
var click_tscn = preload("res://tscn/Click.tscn")
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			# 鼠标左键被按下
			var mouse_position = get_viewport().get_mouse_position()
			var click_instance = click_tscn.instance()
			add_child(click_instance)
			click_instance.position = mouse_position
			# 你可以在这里添加更多的逻辑，比如在点击位置显示一个标记
