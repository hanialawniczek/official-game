extends Node

var feathers = 0

func _process(delta: float) -> void:
	$"interphase/Label".text = str(feathers)
	pass
