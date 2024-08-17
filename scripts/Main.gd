extends Node3D

var sponges;
var waterRising = false;
var placementAngle = 0.0;
var spongeCount = 10;

var cameraslidePlayed = false;

@onready var waterStartY = $Water.position.y;
@onready var camera = $Camera3D

@onready var cameraAnimator : AnimationPlayer = camera.get_child(0);

func _ready():
    cameraAnimator = camera.get_child(0)
    cameraAnimator.play("CameraStart");

    
    getScore();
    pass;

func _process(delta):
    if spongeCount == 0: turnOnTap();

    if waterRising:
        if Globals.waterLevel < 1:
            Globals.waterLevel += 1.2 * delta;
        else:
            if !cameraslidePlayed: 
                cameraAnimator.play("camera_slide");
                cameraslidePlayed = true;
            waterRising = false;

    $Water.position.y = lerp(waterStartY, 0.05, Globals.waterLevel)

func turnOnTap():
    sponges = $Sponges.get_children()
    Globals.water_risen = true;
    waterRising = true;

func getScore():
    var resolution = 100;
    var score = 0.0;

    for x in range(resolution):
        for y in range(resolution):
            var xPos = 1.0 / resolution * x - 1.0;
            var yPos = 1.0 / resolution * y - 1.0;

            var from = Vector3(xPos, 1, yPos);
            var to = Vector3(xPos, -1, yPos);

            var space = get_world_3d().direct_space_state
            var ray_query = PhysicsRayQueryParameters3D.new();
            ray_query.from = from;
            ray_query.to = to;

            var result = space.intersect_ray(ray_query);

            if (len(result) > 0):
                if result["collider"].name != "FloorDetection": score += 1;

    print(score / (resolution * resolution) * 100);

func _physics_process(delta: float) -> void:
    Globals.time_elapsed += delta;
    RenderingServer.global_shader_parameter_set("time_elapsed", Globals.time_elapsed + delta)

    $Cursor.rotation_degrees.y = placementAngle;

func _input(event):
    if event is InputEventKey:
        if event.keycode == KEY_W: turnOnTap();
        if event.keycode == KEY_R and !Input.is_key_pressed(KEY_R): 
            Globals.resetWater();
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
        ray_query.collision_mask = pow(2, 10-1);
        # ray_query.collide_with_areas = true
        # raycast_result = space.intersect_ray(ray_query)
        if len(space.intersect_ray(ray_query)) > 0:
            $Cursor.position.x = space.intersect_ray(ray_query)["position"]["x"];
            $Cursor.position.z = space.intersect_ray(ray_query)["position"]["z"];
            $Cursor.visible = true;
        else:
            $Cursor.visible = false;

    if event is InputEventMouseButton:
        if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
            getScore();
        elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
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
