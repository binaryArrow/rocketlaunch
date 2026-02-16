extends RigidBody2D

const ROTATION_SPEED = 3.0 
const THRUST_FORCE = 800.0  
const MAX_SPEED = 500.0
@onready var timer = $Timer as Timer
@onready var timer_label = %TimerLabel as Label
@onready var animated_sprite = $AnimatedSprite2D as AnimatedSprite2D
@onready var rocket_sprite = $RocketSprite as Sprite2D

@onready var jet_stream = $JetStream as CPUParticles2D


func _ready() -> void:
	set_txt(str(timer.wait_time))
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
	LevelManager.next_level()

func _on_landing_indicator_body_entered(body: Node2D) -> void:
	if body is LandingPlatform:
		timer.start()
		timer_label.visible = true

func _on_landing_indicator_body_exited(_body: Node2D) -> void:
	timer.stop()
	timer_label.visible = false
	set_txt(str(timer.wait_time))

func set_txt(text: String = ""):
	if text != "":
		timer_label.text = text
	else:
		timer_label.text = str(ceil(timer.time_left)).erase(1, 2)

func _on_hit_box_body_entered(_body: Node2D) -> void:
	die()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("WorldBounds"):
		restart_game()

func _on_animated_sprite_2d_animation_finished() -> void:
	restart_game()

func die():
	set_physics_process(false)
	jet_stream.emitting = false
	gravity_scale = 0.0
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	rocket_sprite.visible = false
	animated_sprite.play("die")

func restart_game():
	get_tree().call_deferred("reload_current_scene")


func _on_body_entered(body: Node) -> void:
	print("Collided with: ", body.name)
	if body is Obstacle:
		die()
