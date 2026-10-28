extends CharacterBody2D


const SPEED = 300.0
var movingRight = 1
var canSwich = true
@export var baseDmg = 10


func _physics_process(delta: float) -> void:
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	if !$RayCast2D.is_colliding() and canSwich:
		movingRight *= -1
		canSwich = false
	else:
		canSwich = true
	
	if movingRight < 1:
		velocity.x = SPEED * -1.0
		$RayCast2D. target_position = Vector2(-270, 500)
	else:
		velocity.x = SPEED * 1.0
		$RayCast2D. target_position = Vector2(270, 500)
		
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
		
		
	move_and_slide()	


func _on_area_2d_body_entered(body: Node2D) -> void:
	var dmg = baseDmg * -1
	if body.is_in_group('Player'):
		body.healthChange(dmg, "ice")
