extends Node

var sponges;
var waterRising = false;

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
                    # print(sponge.waterUp);

