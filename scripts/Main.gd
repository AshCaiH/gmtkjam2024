extends Node3D

var sponges;
var waterRising = false;
@onready var camera = $Camera3D

func _ready():
    sponges = $Sponges.get_children()

func _process(delta):
    if waterRising:
        if $Water.position.y < -0.065:
            $Water.position.y += 0.3 * delta;


func _input(event):
    if event is InputEventKey:
        if event.keycode == KEY_W:

            waterRising = true;

            for sponge in sponges:
                sponge = sponge.get_node("RigidBody3D")
                if sponge is Sponge:
                    sponge.waterUp = true;
                    print(sponge.satisfied, sponge.waterUp);

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
