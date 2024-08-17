extends Node3D

var sponges;
var waterRising = false;
var score = 0;
@onready var camera = $Camera3D

func _ready():
	# sponges = $Sponges.get_children()
	pass;

func _process(delta):
	if waterRising:
		if $Water.position.y < 0.05:            
			$Water.position.y += 0.3 * delta;

func _physics_process(delta: float) -> void:
	Globals.time_elapsed += delta;
	RenderingServer.global_shader_parameter_set("time_elapsed", Globals.time_elapsed + delta)
	
	sponges = $Sponges.get_children();
	score = 0;
	for sponge in sponges:
		sponge = sponge.get_node("Sponge")
		if sponge is Sponge:
			score += sponge.area
	
	print(score)

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_W:
			sponges = $Sponges.get_children()
			waterRising = true;

			for sponge in sponges:
				sponge = sponge.get_node("Sponge")
				if sponge is Sponge:
					sponge.waterUp = true;
		if event.keycode == KEY_R:
			get_tree().reload_current_scene()

	if event is InputEventMouseMotion:
	# if event.is_pressed():
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_length = 100
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * ray_length
		var space = get_world_3d().direct_space_state
		var ray_query = PhysicsRayQueryParameters3D.new()
		ray_query.from = from
		ray_query.to = to
		# ray_query.collide_with_areas = true
		# raycast_result = space.intersect_ray(ray_query)
		if len(space.intersect_ray(ray_query)) > 0:
			$Cursor.position.x = space.intersect_ray(ray_query)["position"]["x"];
			$Cursor.position.z = space.intersect_ray(ray_query)["position"]["z"];
			$Cursor.visible = true;
		else:
			$Cursor.visible = false;

	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if len($Cursor.touching) <= 1 and !waterRising:
				var newSponge : Node3D = $SpongePrime.duplicate();
				newSponge.visible = true;
				newSponge.position = $Cursor.position;
				newSponge.position.y = 0.087;
				$Sponges.add_child(newSponge);
