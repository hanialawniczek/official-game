extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _level1_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")


func _level2_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_2.tscn")


func _level3_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_3.tscn")


func _level4_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_4.tscn")
