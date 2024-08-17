class_name Sponge
extends RigidBody3D

var growSpeed = -0.5;
var satisfied = false;
var oldscale = scale;
# var scaleX = true;
# var scaleZ = true;
var baseYPos = position.y;

var maxsize;
var overscale = false;
var overscaleDecline = 0;


@onready var mesh = get_child(0).mesh
# @onready var toy = $Toy;

func _ready():
    add_to_group("sponges");

func _physics_process(delta: float) -> void:
    if Globals.water_risen:
        # Handles bobbing effect, should match shader timing.
        var offset = sin(Globals.time_elapsed*1.0 - to_global(position).x * 5) * 0.004 + \
                      sin(Globals.time_elapsed*2.5 - to_global(position).z * 5) * 0.004
        baseYPos = 0.1 * Globals.waterLevel + offset;

    position.y = baseYPos;

    if !satisfied and Globals.waterLevel > 0.2:
        oldscale = scale;
        growSpeed += 15.0 * delta;

        scale += Vector3(growSpeed / 2, growSpeed * 0.1, growSpeed / 2) * delta;

    if satisfied and overscale:
        growSpeed -= 80 * delta;
        scale += Vector3(growSpeed / 2, 0.0, growSpeed / 2) * delta;
        if scale.x < maxsize.x :
            scale = maxsize;

func _on_area_3d_body_entered(body: Node3D) -> void:
    if body.name == "FloorDetection": return;
    if !satisfied:
        if self == body: return;
        scale = oldscale;
        satisfied = true;
        maxsize = scale;
        overscale = true;
