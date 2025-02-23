extends Node2D
var smoke_hp = 100
var drink_hp = 100
var timer = Timer.new()
var bar_speed = 10
var key_cooldown = 1.0
var last_s_key_press_time = 0.0
var last_d_key_press_time = 0.0

@onready var cough = $CiggyCough
@onready var smoke_hp_bar = $CanvasLayer/SmokeBar
@onready var drink_hp_bar = $CanvasLayer/DrinkBar

func _ready():
	cough.play()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	start_timer()
	
	smoke_hp_bar.value = smoke_hp
	drink_hp_bar.value = drink_hp
	
func _process(delta: float) -> void:
	smoke_hp -= bar_speed * delta
	smoke_hp_bar.value = smoke_hp
	
	drink_hp -= bar_speed * delta
	drink_hp_bar.value = drink_hp

	update_bar_color(smoke_hp_bar, smoke_hp)
	update_bar_color(drink_hp_bar, drink_hp)
			
func start_timer():
	timer.wait_time = randi_range(10,30)
	timer.start()
	
func _on_timer_timeout():
	cough.play()
	
func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_S) and not Input.is_key_pressed(KEY_D):
		var current_s_time = Time.get_ticks_msec() / 1000.0
		if current_s_time - last_s_key_press_time >= key_cooldown:
			if smoke_hp >= 80:
				smoke_hp = 100
			else:
				smoke_hp += 20
			last_s_key_press_time = current_s_time

	if Input.is_key_pressed(KEY_D) and not Input.is_key_pressed(KEY_S):
		var current_d_time = Time.get_ticks_msec() / 1000.0 
		if current_d_time - last_d_key_press_time >= key_cooldown:
			if drink_hp >= 80:
				drink_hp = 100
			else:
				drink_hp += 20
			last_d_key_press_time = current_d_time

func update_bar_color(bar: ProgressBar, value: float) -> void:
	var hp_ratio = clamp(value / 100.0, 0, 1)  # Normalize between 0 and 1
	var color = Color(1.0 - hp_ratio, hp_ratio, 0)  # Red to green transition
	bar.modulate = color
