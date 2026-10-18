extends RayCast3D

var _prompt_label: Label
var _feedback_label: Label
var _feedback_time_left: float = 0.0


func _ready() -> void:
	enabled = true
	exclude_parent = true
	_build_hud()


func _process(delta: float) -> void:
	if _feedback_time_left > 0.0:
		_feedback_time_left = maxf(0.0, _feedback_time_left - delta)
		_feedback_label.visible = _feedback_time_left > 0.0

	if is_colliding():
		var target := get_collider() as Node
		if target != null and target.is_in_group("interactable"):
			var item_name := str(target.get_meta("interaction_name", "objet"))
			_prompt_label.text = "E  Examiner : " + item_name
			_prompt_label.visible = _feedback_time_left <= 0.0
			return

	_prompt_label.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("interact") or event.is_echo() or not is_colliding():
		return

	var target := get_collider() as Node
	if target == null or not target.is_in_group("interactable"):
		return

	var item_name := str(target.get_meta("interaction_name", "objet"))
	_feedback_label.text = "Vous examinez : " + item_name
	_feedback_label.visible = true
	_feedback_time_left = 2.0
	get_viewport().set_input_as_handled()


func _build_hud() -> void:
	var hud := CanvasLayer.new()
	hud.layer = 10
	add_child(hud)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hud.add_child(center)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.mouse_filter = Control.MOUSE_FILTER_IGNORE
	center.add_child(layout)

	var crosshair := Label.new()
	crosshair.text = "+"
	crosshair.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	crosshair.add_theme_font_size_override("font_size", 22)
	crosshair.add_theme_color_override("font_color", Color(0.9, 0.94, 0.9))
	crosshair.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.9))
	crosshair.add_theme_constant_override("shadow_offset_x", 1)
	crosshair.add_theme_constant_override("shadow_offset_y", 1)
	layout.add_child(crosshair)

	_prompt_label = Label.new()
	_prompt_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_prompt_label.add_theme_font_size_override("font_size", 16)
	_prompt_label.add_theme_color_override("font_color", Color(0.95, 0.9, 0.72))
	_prompt_label.visible = false
	layout.add_child(_prompt_label)

	_feedback_label = Label.new()
	_feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_feedback_label.add_theme_font_size_override("font_size", 16)
	_feedback_label.add_theme_color_override("font_color", Color(0.95, 0.9, 0.72))
	_feedback_label.visible = false
	layout.add_child(_feedback_label)
