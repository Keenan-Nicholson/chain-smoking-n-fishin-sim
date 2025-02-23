extends Node2D

var timer = Timer.new()
@onready var cough = $CiggyCough

func _ready():
	cough.play()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	start_timer()
	
func _process(_delta: float) -> void:
	pass
	
func start_timer():
	timer.wait_time = randi_range(10,30)
	print(timer.get_wait_time())
	timer.start()
	
func _on_timer_timeout():
	cough.play()
