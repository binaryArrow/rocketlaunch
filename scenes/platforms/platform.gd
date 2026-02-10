extends StaticBody2D
class_name Platform

@export var platform_width = 1
@export var landing_zone = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale.x = platform_width

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
