extends Path3D

@export var road_width: float = 6.0

func _ready():
	create_road()


func create_road():
	var mesh_instance = $TrackMesh
	var surface = SurfaceTool.new()

	surface.begin(Mesh.PRIMITIVE_TRIANGLES)

	var points = curve.get_baked_points()

	for i in range(points.size() - 1):
		var p1 = points[i]
		var p2 = points[i + 1]

		var direction = (p2 - p1).normalized()
		var side = Vector3(-direction.z, 0, direction.x)

		var left1 = p1 + side * road_width / 2.0
		var right1 = p1 - side * road_width / 2.0

		var left2 = p2 + side * road_width / 2.0
		var right2 = p2 - side * road_width / 2.0

		surface.add_vertex(left1)
		surface.add_vertex(right1)
		surface.add_vertex(left2)

		surface.add_vertex(right1)
		surface.add_vertex(right2)
		surface.add_vertex(left2)

	mesh_instance.mesh = surface.commit()
	
	var road_material = StandardMaterial3D.new()
	road_material.albedo_color = Color(0.35, 0.35, 0.35)
	mesh_instance.material_override = road_material
