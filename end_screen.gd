extends Node2D

@onready var time_label = %TimeLabel as Label

func _ready() -> void:
	var minutes := int(LevelManager.elapsed_time) / 60
	var seconds := int(LevelManager.elapsed_time) % 60
	time_label.text = "Your Time: %02d:%02d" % [minutes, seconds]