extends StaticBody2D
class_name World

@onready var level_label = %LevelLabel as Label
@onready var time_label = %TimeLabel as Label

func _ready() -> void:
	level_label.text = "Level %d" % (LevelManager.current_level + 1)

func _physics_process(delta: float) -> void:
	LevelManager.elapsed_time += delta
	var minutes := int(LevelManager.elapsed_time) / 60
	var seconds := int(LevelManager.elapsed_time) % 60
	time_label.text = "Time: %02d:%02d" % [minutes, seconds]
