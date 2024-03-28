extends Sprite

export var cx = 0
export var cy = 0

func _ready():
	pass # Replace with function body.
func _process(delta):
	if not cx == 0 or cy == 0:
		$"../../../../Tween".interpolate_property($".","position",position,Vector2(40 * cx - 20,40 * cy - 20),0.5)
