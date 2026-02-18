extends Node

signal died

const MAX_LEVEL := 9
const LEVEL_PATH_TEMPLATE := "res://scenes/levels/level%d.tscn"
const END_SCREEN_PATH := "res://scenes/end_screen.tscn"
var current_level := 0
var elapsed_time: float = 0.0
var death_count: int = 0

func next_level():
	current_level += 1
	var path := LEVEL_PATH_TEMPLATE % current_level
	if current_level > MAX_LEVEL and ResourceLoader.exists(END_SCREEN_PATH):
		change_scene_to(END_SCREEN_PATH)
	elif ResourceLoader.exists(path):
		change_scene_to(path)
	else:
		push_warning("No more levels — level %d not found." % current_level)

func change_scene_to(scene_path: String):
	get_tree().change_scene_to_file(scene_path)

func set_death_count(count: int):
	death_count = count
	emit_signal("died")