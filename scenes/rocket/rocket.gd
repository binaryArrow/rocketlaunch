extends RigidBody2D


const ROTATION_SPEED = 3.0 
const THRUST_FORCE = 800.0  
const MAX_SPEED = 500.0


func _physics_process(_delta: float) -> void:
	var rotation_input = 0.0
	if Input.is_action_pressed("ui_left"):
		rotation_input -= 1.0
	if Input.is_action_pressed("ui_right"):
		rotation_input += 1.0
	
	angular_velocity = rotation_input * ROTATION_SPEED
	
	if Input.is_action_pressed("ui_accept"):
		var thrust_direction = Vector2.UP.rotated(rotation)
		apply_central_force(thrust_direction * THRUST_FORCE)

		if linear_velocity.length() > MAX_SPEED:
			linear_velocity = linear_velocity.normalized() * MAX_SPEED
