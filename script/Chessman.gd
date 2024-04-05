extends Sprite

export var cx = 0
export var cy = 0
var cr = 0
var pcx = cx
var pcy = cy
func _ready():
	$Timer.start()
func _process(delta):
	if not (cx == 0 or cy == 0):
		$"../../../../Tween".interpolate_property($".","position",position,Vector2(40 * cx - 20,40 * cy - 20),0.5)
	if $Timer.time_left == 0:
		if cr % 4 == 0:
			$"../../../../Tween".interpolate_property($".","global_rotation_degrees",global_rotation_degrees,0,0.5)
			$"../../../../Tween".start()
		if cr % 4 == 1:
			$"../../../../Tween".interpolate_property($".","global_rotation_degrees",global_rotation_degrees,90,0.5)
			$"../../../../Tween".start()
		if cr % 4 == 2:
			$"../../../../Tween".interpolate_property($".","global_rotation_degrees",global_rotation_degrees,180,0.5)
			$"../../../../Tween".start()
		if cr % 4 == 3:
			$"../../../../Tween".interpolate_property($".","global_rotation_degrees",global_rotation_degrees,-90,0.5)
			$"../../../../Tween".start()
