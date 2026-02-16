extends Node

const LEVEL_PATH_TEMPLATE := "res://scenes/levels/level%d.tscn"
var current_level := 0

func next_level():
	current_level += 1
	var path := LEVEL_PATH_TEMPLATE % current_level
	print("Loading level: ", path)
	if ResourceLoader.exists(path):
		change_scene_to(path)
	else:
		push_warning("No more levels — level %d not found." % current_level)

func change_scene_to(scene_path: String):
	get_tree().change_scene_to_file(scene_path)
