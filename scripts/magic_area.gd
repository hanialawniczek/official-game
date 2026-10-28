extends Area2D
var speed = 1500
var velocity
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.connect("timeout", _on_timer_timeout)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction == 1:
		velocity = Vector2(-1, 0).rotated(rotation_degrees) * speed * delta
		$Magic/CPUParticles2D.gravity.x = 300
		$Magic/CPUParticles2D.gravity.x = 980
	else:
		velocity = Vector2(1, 0).rotated(rotation_degrees) * speed * delta
		$Magic/CPUParticles2D.gravity.x = -300
		$Magic/CPUParticles2D.gravity.x = 980
	position+= velocity
	pass
	
func _on_timer_timeout():
	queue_free()
