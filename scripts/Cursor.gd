extends Node3D

var touching = [];

func _physics_process(delta: float) -> void:
    if len(touching) > 1: visible = false;
    else: visible = true;

    position.x = clamp(position.x, -0.85, 0.85);
    position.z = clamp(position.z, -0.85, 0.85);

func _on_area_3d_body_entered(body: Node3D) -> void:
    touching.append(body);
    print(body.name);

func _on_area_3d_body_exited(body: Node3D) -> void:
    touching.remove_at(touching.find(body))
    print("left", body.name);