extends Sprite

export var cx = 0
export var cy = 0

func _ready():
	pass # Replace with function body.
func _process(delta):
	if not cx == 0:
		position.x = 40 * cx - 20
	if not cy == 0:
		position.y = 40 * cy - 20
