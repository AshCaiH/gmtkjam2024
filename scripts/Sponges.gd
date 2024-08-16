extends Node3D

var spongeList = [];
var spongeScript = load("res://scripts/Sponge.gd");
@export var spongePrime : Node3D;

func _ready() -> void:
	var templist = get_children()

    # Bad and sloppy but I just need something that works for now. (Plus I can't find a way to just add a script )
	for sponge in templist:
		var newSponge : Node3D = spongePrime.duplicate();
		newSponge.visible = true
		add_child(newSponge);

		remove_child(sponge); 

		
