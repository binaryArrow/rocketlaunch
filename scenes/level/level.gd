extends Node2D


func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("Rocket crashed! Restarting level...")
	get_tree().call_deferred("reload_current_scene")


func _on_rocket_landed() -> void:
	print("Rocket has landed successfully!")
