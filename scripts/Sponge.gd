class_name Sponge
extends RigidBody3D

var growSpeed = 10.0;
var satisfied = false;
var oldscale = scale;
# var scaleX = true;
# var scaleZ = true;
var waterUp := false;
var baseYPos = position.y;

# var customMesh = load("res://assets/models/rabbit.glb")

@onready var mesh = $Sponge.get_child(0).mesh
# @onready var toy = $Toy;

func _ready():
    add_to_group("sponges");

func _physics_process(delta: float) -> void:
    if waterUp:
        # Handles bobbing effect, should match shader timing.
        var offset = sin(Globals.time_elapsed*1.0 - to_global(position).x * 5) * 0.1 + \
                      sin(Globals.time_elapsed*2.5 - to_global(position).z * 5) * 0.1
        baseYPos = 0.9 + offset;

    position.y = baseYPos;

    if !satisfied and waterUp:
        oldscale = scale;
        # growSpeed -= 0.1 * delta;

        # if scaleX and scaleZ:
        scale += Vector3(growSpeed / 2, growSpeed * 0.1, growSpeed / 2) * delta;
        # elif scaleX:
        #     scale.x += growSpeed  * delta;
        # elif scaleZ:
        #     scale.z += growSpeed  * delta;

        for i in range(8):
            var endpoints = to_global(mesh.get_aabb().get_endpoint(i))
            if endpoints.x < -1 or endpoints.x > 1 \
                or endpoints.z < -1 or endpoints.z > 1:
                satisfied = true;

        # toy.scale = Vector3(1.0, 1.0, 1.0) / scale;
        # mesh.material.uv1_scale = scale;
        # toy.position = Vector3(1 - scale.x, 0.5, 1 - scale.z);

func _on_area_3d_body_entered(body: Node3D) -> void:
    if body.name == "FloorDetection": return;
    if !satisfied:
        if self == body: return;
        scale = oldscale;
        satisfied = true;