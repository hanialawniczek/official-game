@tool
class_name SmoothPath
extends Path2D

@export var spline_length = 8
@export var _smooth: bool: set = smooth
@export var _straighten: bool: set = straighten
@export var color: Color = Color(1,1,1,1)
@export var width : float = 0

func straighten(value: bool) -> void:
	if not value:
		return
	for i in range(curve.get_point_count()):
		curve.set_point_in(i, Vector2.ZERO)
		curve.set_point_out(i, Vector2.ZERO)

# Smooths the path based on the neighboring points
func smooth(value: bool) -> void:
	if not value:
		return

	var point_count = curve.get_point_count()
	for i in range(point_count):
		var spline = _get_spline(i)
		curve.set_point_in(i, -spline)
		curve.set_point_out(i, spline)

# Calculates the spline vector based on neighboring points
func _get_spline(i: int) -> Vector2:
	var last_point = _get_point(i - 1)
	var next_point = _get_point(i + 1)
	return last_point.direction_to(next_point) * spline_length

# Retrieves the position of a point in the curve, wrapping around if necessary
func _get_point(i: int) -> Vector2:
	var point_count = curve.get_point_count()
	i = wrapi(i, 0, point_count - 1)
	return curve.get_point_position(i)

# Draws the path using the baked points
func _draw() -> void:
	var points = curve.get_baked_points()
	if points.size() > 0:
		draw_polyline(points, color, width, false)
