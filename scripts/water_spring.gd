extends Node2D

var velocity = 0
var force = 0
#current position
var height = 0
#natural position
var target_height = 0

@onready var collision = $Area2D/CollisionShape2D

var index = 0
#how much object affects the water
@export var motion_factor = 2

signal splash


func water_update( spring_constant, dampening):
	#This function applies the hooke's law force to the spring!!
	#This function will be cal led in each frame

	#update the height value based on our current postition
	height = position.y
	#the spring current extension
	var x = height - target_height
	
	var loss = -dampening * velocity

	#hooke's law
	force = -spring_constant * x + loss

	velocity += force
	
	#make the spring move
	position.y += velocity
	pass

func initialize(x_position, id) -> void:
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
	index = id

func set_collision_width(value) -> void:
	var extents = collision.shape.size
	var new_extents = Vector2(value, extents.y)
	collision.shape.set_size(new_extents)
	pass
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	var speed =  motion_factor
	emit_signal("splash", index, speed)
	
	
	pass # Replace with function body.
