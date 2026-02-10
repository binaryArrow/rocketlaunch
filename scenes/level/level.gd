extends Node2D


func _on_offscreen(_body: Node2D) -> void:
	restart_game()

func _on_rocket_landed() -> void:
	print("Rocket has landed successfully!")

func _on_character_body_2d_crashed() -> void:
	restart_game()

func restart_game():
	print("Rocket crashed! Restarting level...")
	get_tree().call_deferred("reload_current_scene")

	
