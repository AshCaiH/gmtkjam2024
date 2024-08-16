extends RigidBody3D

var growSpeed = 10.0;
var satisfied = false;
var oldscale = scale;
var scaleX = true;
var scaleZ = true;

# var customMesh = load("res://assets/models/rabbit.glb")

@onready var mesh = $Sponge.get_node("Cube").mesh
@onready var toy = $Toy;

func _ready():  
    for i in range(8):
        var endpoints = mesh.get_aabb().get_endpoint(i)
        print(to_global(endpoints))

    contact_monitor = true;
    max_contacts_reported = 2;

    # scaleX = randi() % 2;
    # scaleZ = randi() % 2;

    add_to_group("sponges");

func _physics_process(delta: float) -> void:
    if !satisfied:
        oldscale = scale;

        if scaleX and scaleZ:
            scale += Vector3(growSpeed / 2, 0, growSpeed / 2) * delta;
        elif scaleX:
            scale.x += growSpeed  * delta;
        elif scaleZ:
            scale.z += growSpeed  * delta;

        for i in range(8):
            var endpoints = to_global(mesh.get_aabb().get_endpoint(i))
            if endpoints.x < -1 or endpoints.x > 1 \
                or endpoints.z < -1 or endpoints.z > 1:
                satisfied = true;

        toy.scale = Vector3(1.0, 1.0, 1.0) / scale;
        # mesh.material.uv1_scale = scale;
        # toy.position = Vector3(1 - scale.x, 0.5, 1 - scale.z);

        print(get_contact_count());

func _on_area_3d_body_entered(body: Node3D) -> void:
    if !satisfied:
        if self == body: return;
        scale = oldscale;
        satisfied = true;