extends Node3D

var sponges;
var waterRising = false;
var placementAngle = 0.0;
var spongeCount = 10;

var waterPosition = 0;
@onready var waterStartY = $Water.position.y;
@onready var camera = $Camera3D

func _ready():
    # sponges = $Sponges.get_children()
    pass;

func _process(delta):
    if spongeCount == 0: turnOnTap();

    if waterRising:
        if waterPosition < 1:
            waterPosition += 1.5 * delta;

        $Water.position.y = lerp(waterStartY, 0.05, waterPosition)
        # if $Water.position.y < 0.05:
        #     $Water.position.y += 0.3 * delta;

func turnOnTap():
    sponges = $Sponges.get_children()
    waterRising = true;

    for sponge in sponges:
        sponge = sponge.get_child(0);
        if sponge is Sponge:
            sponge.waterUp = true;

func _physics_process(delta: float) -> void:
    Globals.time_elapsed += delta;
    RenderingServer.global_shader_parameter_set("time_elapsed", Globals.time_elapsed + delta)

    $Cursor.rotation_degrees.y = placementAngle;

func _input(event):
    if event is InputEventKey:
        if event.keycode == KEY_W: turnOnTap();
        if event.keycode == KEY_R: get_tree().reload_current_scene()

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
            var random = randi();
            if len($Cursor.touching) <= 1 and !waterRising:
                var newSponge : Node3D;
                if random % 2: newSponge = $SpongePrime.duplicate();
                else: newSponge = $RabbitPrime.duplicate();
                newSponge.visible = true;
                newSponge.position = $Cursor.position;
                newSponge.position.y = 0.087;
                newSponge.rotation_degrees.y = placementAngle;
                $Sponges.add_child(newSponge);

                placementAngle = randf() * 360;

                spongeCount -= 1;
