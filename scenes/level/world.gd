extends StaticBody2D
class_name World

@onready var level_label = %LevelLabel as Label

func _ready() -> void:
	level_label.text = "Level %d" % (LevelManager.current_level + 1)
	print(level_label.text)
