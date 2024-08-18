extends Node

var time_elapsed = 0;
var camera_mode = 0;
var water_risen = false;
var waterLevel = 0; # Goes from 0-1.
var score = 0;

var hardMode = false;

func resetWater():
    waterLevel = 0;
    water_risen = false;

    get_tree().reload_current_scene()