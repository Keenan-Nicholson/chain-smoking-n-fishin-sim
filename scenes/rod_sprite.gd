extends Node2D

var target_rotation = 0
var rotating = false
var rotation_duration = 1.0 
var elapsed_time = 0.0

func _process(delta: float) -> void:
	if rotating:
		elapsed_time += delta
		var progress = elapsed_time / rotation_duration
		if progress <= 0.5:
			rotation = lerp(0, 1, progress * 2)
		elif progress <= 1.0:
			rotation = lerp(1, 0, (progress - 0.5) * 2)
		else:
			rotation = 0
			rotating = false
			elapsed_time = 0.0

func _input(event):
	if event.is_action_pressed("ui_accept") and not rotating:
		rotating = true
		elapsed_time = 0.0
