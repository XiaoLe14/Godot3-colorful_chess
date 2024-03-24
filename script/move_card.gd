extends TouchScreenButton
var up = false
signal move_card_click(id)
onready var start_pos = position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_TextureButton_pressed():
	_on_pressed()


func _on_TextureButton_mouse_entered():
	_on_entered()

func _on_move_card_pressed():
	if up:
		_on_exited()
		up = false
		_on_click()
	else:
		_on_entered()
		_on_pressed()
		up = true

func _on_TextureButton_mouse_exited():
	_on_exited()
func _on_pressed():
	_on_click()
func _on_entered():
	var to_position = start_pos
	to_position.y -= 20
	$Tween.interpolate_property($".","position",start_pos,to_position, 0.1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
func _on_exited():
	var to_position = start_pos
	to_position.y += 20
	$Tween.interpolate_property($".","position",start_pos,to_position, 0.1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_click():
	emit_signal("move_card_click",normal.load_path)