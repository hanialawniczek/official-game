extends CharacterBody2D


const SPEED = 400.0
@onready var player = get_tree().get_first_node_in_group("Characters")
@export var baseDmg = 10
var tracking = 0
var direction


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if tracking:
		direction = position.direction_to(player.global_position).normalized()
		velocity = direction * SPEED
	#else:
		#velocity = Vector2(0,0)
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	var dmg = baseDmg * -1
	if body.is_in_group('Player'):
		body.healthChange(dmg, "poison")
		direction = position.direction_to(player.global_position).normalized()
		tracking = 0
		velocity = -direction * SPEED * 2
		await get_tree().create_timer(0.5).timeout
		tracking = 1
	pass # Replace with function body.


func _on_tracking_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		tracking = 1

	pass # Replace with function body.


func _on_tracking_body_exited(body: Node2D) -> void:
	if body.is_in_group('Player'):
		tracking = 0
		velocity = Vector2(0,0)
	pass # Replace with function body.
