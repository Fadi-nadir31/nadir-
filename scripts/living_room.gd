extends Node3D


func _ready() -> void:
	_build_lighting()
	_build_room()
	_build_furniture()


func _build_lighting() -> void:
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.025, 0.035, 0.05)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.32, 0.36, 0.42)
	environment.ambient_light_energy = 0.45

	var world := WorldEnvironment.new()
	world.environment = environment
	add_child(world)

	var moonlight := DirectionalLight3D.new()
	moonlight.rotation_degrees = Vector3(-38.0, -24.0, 0.0)
	moonlight.light_color = Color(0.58, 0.68, 0.82)
	moonlight.light_energy = 0.35
	moonlight.shadow_enabled = true
	add_child(moonlight)


func _build_room() -> void:
	_add_box("Floor", Vector3(12.0, 0.2, 12.0), Vector3(0.0, -0.1, 0.0), Color(0.24, 0.19, 0.15))
	_add_box("BackWall", Vector3(12.0, 3.0, 0.2), Vector3(0.0, 1.5, -6.0), Color(0.31, 0.34, 0.32))
	_add_box("LeftWall", Vector3(0.2, 3.0, 12.0), Vector3(-6.0, 1.5, 0.0), Color(0.27, 0.3, 0.29))
	_add_box("RightWall", Vector3(0.2, 3.0, 12.0), Vector3(6.0, 1.5, 0.0), Color(0.27, 0.3, 0.29))
	_add_box("FrontWallLeft", Vector3(3.0, 2.3, 0.2), Vector3(-4.5, 1.15, 6.0), Color(0.27, 0.3, 0.29))
	_add_box("FrontWallRight", Vector3(3.0, 2.3, 0.2), Vector3(4.5, 1.15, 6.0), Color(0.27, 0.3, 0.29))
	_add_box("DoorHeader", Vector3(6.0, 0.7, 0.2), Vector3(0.0, 2.65, 6.0), Color(0.27, 0.3, 0.29))
	_add_box("Ceiling", Vector3(12.0, 0.2, 12.0), Vector3(0.0, 3.1, 0.0), Color(0.2, 0.22, 0.21), false, false)


func _build_furniture() -> void:
	_add_box("SofaSeat", Vector3(3.0, 0.45, 0.95), Vector3(0.0, 0.42, -3.55), Color(0.34, 0.18, 0.14), true, true, "Canapé")
	_add_box("SofaBack", Vector3(3.0, 1.0, 0.3), Vector3(0.0, 1.0, -3.95), Color(0.39, 0.21, 0.16))
	_add_box("SofaArmLeft", Vector3(0.35, 0.75, 0.95), Vector3(-1.33, 0.78, -3.55), Color(0.39, 0.21, 0.16))
	_add_box("SofaArmRight", Vector3(0.35, 0.75, 0.95), Vector3(1.33, 0.78, -3.55), Color(0.39, 0.21, 0.16))

	_add_box("CoffeeTable", Vector3(2.1, 0.14, 1.0), Vector3(0.0, 0.62, -1.35), Color(0.38, 0.26, 0.17), true, true, "Table basse")
	_add_box("Book", Vector3(0.34, 0.08, 0.25), Vector3(0.55, 0.73, -1.35), Color(0.61, 0.42, 0.19), true, true, "Livre")
	_add_box("Cabinet", Vector3(1.6, 1.0, 0.55), Vector3(3.9, 0.5, -4.9), Color(0.28, 0.2, 0.16), true, true, "Commode")
	_add_box("WallPicture", Vector3(1.3, 0.9, 0.08), Vector3(-2.5, 1.9, -5.86), Color(0.12, 0.19, 0.2), true, true, "Cadre")


func _add_box(
	object_name: String,
	size: Vector3,
	box_position: Vector3,
	color: Color,
	with_collision: bool = true,
	is_interactable: bool = false,
	interaction_name: String = ""
) -> StaticBody3D:
	var body := StaticBody3D.new()
	body.name = object_name
	body.position = box_position
	add_child(body)

	var mesh_instance := MeshInstance3D.new()
	var box_mesh := BoxMesh.new()
	box_mesh.size = size
	mesh_instance.mesh = box_mesh
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	mesh_instance.material_override = material
	body.add_child(mesh_instance)

	if with_collision:
		var collision := CollisionShape3D.new()
		var box_shape := BoxShape3D.new()
		box_shape.size = size
		collision.shape = box_shape
		body.add_child(collision)

	if is_interactable:
		body.add_to_group("interactable")
		body.set_meta("interaction_name", interaction_name)

	return body
