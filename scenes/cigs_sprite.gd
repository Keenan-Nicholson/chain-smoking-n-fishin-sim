extends Sprite2D

var original_position = Vector2.ZERO
var shake_intensity = 5.0

func _ready():
	original_position = position
	
func _process(delta: float) -> void:
	position = original_position + Vector2(
		randf_range(-shake_intensity, shake_intensity),
		randf_range(-shake_intensity, shake_intensity)
		)
			
