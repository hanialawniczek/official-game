extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		$AnimatedSprite2D.play("head")
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('Player'):
		$AnimatedSprite2D.play_backwards("head")
		await get_tree().create_timer(1).timeout
		$AnimatedSprite2D.play("idle")
	pass # Replace with function body.
