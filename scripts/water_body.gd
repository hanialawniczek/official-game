extends Node2D
#spring stiffness
@export var k = 0.02
#spring dampening value
@export var d = 0.02
#how much the waves will spread to their netghboors
@export var spread = 0.0002
#the spring array
var springs = []
@export var passes = 8

#distance in pixel between each spring
@export var distance_between_springs = 150
#number of springs in the scene
@export var spring_number = 15

#total water body lenght
var water_lenght = distance_between_springs * spring_number
#spring scene reference

@onready var water_spring = preload("res://scenes/water_spring.tscn")

#water polygon
@export var depth = 500
var target_height = global_position.y
var bottom = target_height + depth
@onready var water_polygon = $water_polygon

#water border
@onready var water_border = $water_border
@export var border_thickness = 5

@export var player: CharacterBody2D

#initializes the spring array and all the springs
func _ready() -> void:
	water_border.width = border_thickness
	
	
	for i in range(spring_number):
		var x_position = distance_between_springs * i
		var w = water_spring.instantiate()
		
		add_child(w)
		springs.append(w)
		w.initialize(x_position, i)
		w.set_collision_width(distance_between_springs)
		w.connect("splash", Callable(self, "splash"))
		
		


func _process(delta: float) -> void:
	for i in springs:
		i.water_update(k,d)
	
	var left_deltas = []
	var right_deltas = []
	
	for i in range (springs.size( )):
		left_deltas.append(0)
		right_deltas.append(0)
		pass
		
		
	for j in range(passes):
		#loops through each spring of our array
		for i in range (springs.size( )):
			if i > 0:
				left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
				springs[i-1].velocity += left_deltas[i]
			if i < springs.size()-1:
				right_deltas[i] = spread * (springs[i].height - springs[i+1].height)
				springs[i+1].velocity += right_deltas[i]
	
	new_border()
	draw_water_polygon()
	

			
#adds a speed to a spring with this index
func splash( index, speed):
	if index >= 0 and index < springs.size():
		springs[index].velocity += speed
		
		
func draw_water_polygon():
	#holds positions of springs
	var surface_points = []
	for i in range(springs.size()):
		surface_points.append(springs[i].position)
		
	var first_index = 0
	var last_index = surface_points.size()-1
	
	#the water polygon will contain all the points of the surface
	var water_polygon_points = surface_points
	#add other two points at the bottom of the polygon
	water_polygon_points.append(Vector2(surface_points[last_index].x,bottom))
	water_polygon_points.append(Vector2(surface_points[first_index].x,bottom))
	water_polygon_points = PackedVector2Array(water_polygon_points)
	water_polygon.set_polygon(water_polygon_points)
	
	
func new_border():
	var curve = Curve2D.new().duplicate()
	
	var surface_points = []
	for i in(springs.size()):
		surface_points.append(springs[i].position)
		
	for i in(surface_points.size()):
		curve.add_point(surface_points[i])
		
	water_border.curve = curve
	water_border.smooth(true)
	water_border.queue_redraw()
	pass
