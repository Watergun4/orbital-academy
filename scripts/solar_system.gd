extends Node3D

@export var system_scale := 1.0   # make the whole model bigger/smaller
@export var time_speed := 1.0     # make orbits faster/slower

var pivots: Array[Node3D] = []
var speeds: Array[float] = []


func _ready() -> void:
	scale = Vector3.ONE * system_scale
	_make_sun()
	for planet in PlanetData.PLANETS:
		_make_planet(planet)


func _process(delta: float) -> void:
	# Each planet sits on a pivot at the centre; turning the pivot moves the planet in a circle
	for i in pivots.size():
		pivots[i].rotate_y(speeds[i] * time_speed * delta)


func _make_sun() -> void:
	var sun := _make_sphere(PlanetData.SUN.radius, PlanetData.SUN.color)
	sun.name = "Sun"
	# Unshaded = the Sun glows and isn't affected by lights
	var material := sun.material_override as StandardMaterial3D
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	add_child(sun)

	# Light coming from the Sun so the planets have a lit side and a dark side
	var light := OmniLight3D.new()
	light.omni_range = 3.0
	light.light_energy = 2.0
	add_child(light)


func _make_planet(data: Dictionary) -> void:
	# Pivot at the centre, starting at a random angle so planets aren't in a line
	var pivot := Node3D.new()
	pivot.name = data.name + "Pivot"
	pivot.rotation.y = randf() * TAU
	add_child(pivot)

	var planet := _make_sphere(data.radius, data.color)
	planet.name = data.name
	planet.position = Vector3(data.distance, 0, 0)
	pivot.add_child(planet)

	if data.has("rings"):
		planet.add_child(_make_rings(data.radius))

	add_child(_make_orbit_line(data.distance))

	pivots.append(pivot)
	speeds.append(data.speed)


func _make_sphere(radius: float, color: Color) -> MeshInstance3D:
	var mesh := SphereMesh.new()
	mesh.radius = radius
	mesh.height = radius * 2.0

	var material := StandardMaterial3D.new()
	material.albedo_color = color

	var sphere := MeshInstance3D.new()
	sphere.mesh = mesh
	sphere.material_override = material
	return sphere


func _make_orbit_line(distance: float) -> MeshInstance3D:
	# A very thin torus (doughnut) makes a neat circle
	var mesh := TorusMesh.new()
	mesh.inner_radius = distance - 0.001
	mesh.outer_radius = distance + 0.001
	mesh.rings = 96
	mesh.ring_segments = 4

	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color = Color(1, 1, 1, 0.25)

	var line := MeshInstance3D.new()
	line.mesh = mesh
	line.material_override = material
	return line


func _make_rings(planet_radius: float) -> MeshInstance3D:
	# A wide torus squashed flat
	var mesh := TorusMesh.new()
	mesh.inner_radius = planet_radius * 1.3
	mesh.outer_radius = planet_radius * 2.2
	mesh.rings = 64
	mesh.ring_segments = 16

	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.9, 0.8, 0.6, 0.8)
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA

	var rings := MeshInstance3D.new()
	rings.mesh = mesh
	rings.material_override = material
	rings.scale = Vector3(1, 0.05, 1)    # squash flat
	rings.rotation_degrees.z = 15        # slight tilt
	return rings
