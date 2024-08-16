extends Node3D

var growSpeed = 10;
var satisfied = false;
@onready var mesh = $MeshInstance3D.mesh

func _ready():  

    # print($MeshInstance3D.mesh.get_aabb())

    for i in range(8):
        var endpoints = mesh.get_aabb().get_endpoint(i)
        print(to_global(endpoints))

func _process(delta):
    if !satisfied:
        # var oldScale = scale.x;

        scale.x += growSpeed * delta;

        for i in range(8):
            var endpoints = to_global(mesh.get_aabb().get_endpoint(i))
            if endpoints.x < -1 or endpoints.x > 1 \
                or endpoints.z < -1 or endpoints.z > 1:
                satisfied = true;

        # var positionX = (mesh.get_aabb() * global_transform).position.x
        # var positionY = (mesh.get_aabb() * global_transform).position.y

        # for i in range(8):
        #     var endpoints = mesh.aabb.get_endpoint(i)
        #     print(endpoints)

        # print(positionX);

        # if positionX < -1 or positionX > 1:
        #     satisfied = true;
        # elif positionY < -1 or positionY > 1:
        #     satisfied = true;