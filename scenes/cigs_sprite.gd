extends Sprite2D

var original_position = Vector2.ZERO
var original_scale = Vector2.ZERO
var shake_intensity = 5.0
var key_cooldown = 1.0
var last_s_key_press_time = 0.0
var last_d_key_press_time = 0.0

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
	if Input.is_key_pressed(KEY_S) and not Input.is_key_pressed(KEY_D):
		var current_s_time = Time.get_ticks_msec() / 1000.0  # Get time in seconds
		if current_s_time - last_s_key_press_time >= key_cooldown:
			scale.x = lerp(0,1,5)
			scale.y = lerp(1,0,0)
			drag.play()
			last_s_key_press_time = current_s_time

	# sip
	if Input.is_key_pressed(KEY_D) and not Input.is_key_pressed(KEY_S):
		var current_d_time = Time.get_ticks_msec() / 1000.0  # Get time in seconds
		if current_d_time - last_d_key_press_time >= key_cooldown:
			scale.x = lerp(0,1,5)
			scale.y = lerp(1,0,0)
			sip.play()
			last_d_key_press_time = current_d_time

			
	if not (Input.is_key_pressed(KEY_D) or Input.is_key_pressed((KEY_S))):
		scale = original_scale
