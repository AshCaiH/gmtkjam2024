extends Node3D

var sponges;
var waterRising = false;
var placementAngle = 0.0;
var spongeCount = 10;

var cameraslidePlayed = false;

@onready var waterStartY = $Water.position.y;
@onready var cursorStartY = $Cursor.position.y;
@onready var camera = $Camera3D
@onready var sounds = $Sounds.get_children();
@onready var flushSound = $FlushSFX;

@onready var cameraAnimator : AnimationPlayer = camera.get_child(0);

func _ready():
    cameraAnimator = camera.get_child(0)
    cameraAnimator.play("CameraStart");

    
    getScore();
    pass;

func _process(delta):
    if spongeCount == 0 and Globals.waterLevel == 0: turnOnTap();

    if waterRising:
        if Globals.waterLevel < 1:
            Globals.waterLevel += 1.2 * delta;
        else:
            if !cameraslidePlayed: 
                cameraAnimator.play("camera_slide");
                cameraslidePlayed = true;
            waterRising = false;
            getScore();
            var timer:SceneTreeTimer = get_tree().create_timer(1.0)
            timer.timeout.connect(gameOver)  

    $Water.position.y = lerp(waterStartY, 0.05, Globals.waterLevel)
    $Cursor.position.y = lerp(cursorStartY, 3.0, Globals.waterLevel)

func gameOver():
    getScore();
    print("score ", Globals.score);
    var summary :Summarybox = $Summarybox;
    summary.visible = true;
    summary.progressbartween();

func turnOnTap():
    if Globals.waterLevel != 0: return;
    sponges = $Sponges.get_children()
    Globals.water_risen = true;
    waterRising = true;
    flushSound.play();

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

    score = score / (resolution * resolution) * 100;
    print(score);
    Globals.score = score;

func _physics_process(delta: float) -> void:
    Globals.time_elapsed += delta;
    RenderingServer.global_shader_parameter_set("time_elapsed", Globals.time_elapsed + delta)

    $Cursor.rotation_degrees.y = placementAngle;

func _input(event):
    if event is InputEventKey:
        if event.keycode == KEY_W: 
            turnOnTap();
        if event.keycode == KEY_R and !Input.is_key_pressed(KEY_R): Globals.resetWater();

    if Globals.waterLevel == 0 and !waterRising:
        if event is InputEventMouseMotion:
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
                if len($Cursor.touching) <= 1 and Globals.waterLevel == 0:
                    var spongeList = $SpongeList.get_children();
                    spongeList.pick_random().queue_free()
                    var newSponge : Node3D;
                    if Globals.hardMode:
                        if random % 2: newSponge = $SpongePrime.duplicate();                        
                        else: newSponge = $RabbitPrime.duplicate();
                    else:
                        newSponge = $SpongePrime.duplicate();  
                    newSponge.visible = true;
                    newSponge.position = $Cursor.position;
                    newSponge.position.y = 0.087;

                    newSponge.rotation_degrees.y = placementAngle;
                    $Sponges.add_child(newSponge);

                    if Globals.hardMode:
                        placementAngle = randf() * 360;


                    spongeCount -= 1;

                    sounds.pick_random().play();
