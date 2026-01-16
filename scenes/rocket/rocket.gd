extends RigidBody2D

const ROTATION_SPEED = 3.0 
const THRUST_FORCE = 800.0  
const MAX_SPEED = 500.0
var WAIT_TIME = 5
@onready var timer = $Timer as Timer
@onready var timer_label = %TimerLabel as Label


@onready var jet_stream = $JetStream as CPUParticles2D


func _ready() -> void:
	set_txt(str(WAIT_TIME))
	timer_label.visible = false

func _physics_process(_delta: float) -> void:
	if timer.time_left > 0.0:
		set_txt()
	var rotation_input = 0.0
	if Input.is_action_pressed("ui_left"):
		rotation_input -= 1.0
	if Input.is_action_pressed("ui_right"):
		rotation_input += 1.0
	
	angular_velocity = rotation_input * ROTATION_SPEED
	
	if Input.is_action_pressed("ui_accept"):
		jet_stream.emitting = true
		var thrust_direction = Vector2.UP.rotated(rotation)
		apply_central_force(thrust_direction * THRUST_FORCE)
		if linear_velocity.length() > MAX_SPEED:
			linear_velocity = linear_velocity.normalized() * MAX_SPEED

	if Input.is_action_just_released("ui_accept"):
		jet_stream.emitting = false

func _on_timer_timeout() -> void:
	timer_label.text = "LANDING SUCCESSFUL"
	

func _on_landing_indicator_body_entered(_body: Node2D) -> void:
	timer.start()
	timer_label.visible = true

func _on_landing_indicator_body_exited(_body: Node2D) -> void:
	timer.stop()
	timer.wait_time = WAIT_TIME
	timer_label.visible = false
	set_txt(str(WAIT_TIME))

func set_txt(text: String = ""):
	if text != "":
		timer_label.text = text
	else:
		timer_label.text = str(ceil(timer.time_left)).erase(1, 2)