extends SpotLight3D

@export var toggle_action: StringName = &"toggle_flashlight"


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(toggle_action) and not event.is_echo():
		visible = not visible
		get_viewport().set_input_as_handled()
