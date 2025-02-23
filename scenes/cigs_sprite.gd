extends Sprite2D

var original_position = Vector2.ZERO
var original_scale = Vector2.ZERO
var shake_intensity = 5.0
@onready var drag = $"../Drag"
@onready var sip = $"../Sip"

func _ready():
	original_position = position
	original_scale = scale
	
func _process(_delta: float) -> void:
	position = original_position + Vector2(
		randf_range(-shake_intensity, shake_intensity),
		randf_range(-shake_intensity, shake_intensity)
		)
	
func _input(_event: InputEvent) -> void:
	# smoke
	if Input.is_key_pressed(KEY_S):
		scale.x = lerp(0,1,1)
		scale.y = lerp(1,0,0)
		drag.play()
	# sip
	if Input.is_key_pressed(KEY_D):
		scale.x = lerp(0,1,1)
		scale.y = lerp(1,0,0)
		sip.play()
	if not (Input.is_key_pressed(KEY_D) or Input.is_key_pressed((KEY_S))):
		scale = original_scale
