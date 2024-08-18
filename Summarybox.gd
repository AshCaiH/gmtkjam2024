class_name Summarybox
extends Control
@onready var continuebutton = %Continuebutton
@onready var commenttimer = %commenttimer
@onready var v_box_container = %VBoxContainer
@onready var target = %Target
@onready var progress_bar = v_box_container.get_node("ProgressBar")
@onready var try_again = %"Try Again"
@onready var commentlabel = %Commentlabel
var targetvolume = 50;

var nextscene := ""

# Called when the node enters the scene tree for the first time.
func _ready():
	commenttimer.start()
	buttonpress()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func dialogue() -> void:
	commenttimer.timeout().connect(progressbartween)
	
func progressbartween() -> void:
	var tween := create_tween()
	tween.tween_property(progress_bar, "value", Globals.score, 1.5).set_trans(tween.TRANS_QUAD)
	# tween.finished.connect(commentandbutton)

func commentandbutton() -> void:
	var tween2 := create_tween()
	tween2.tween_property(commentlabel, "modulate.a", 1, 0)
	
	if Globals.score >= targetvolume:
		try_again.text = "Next Level!"
		nextscene = ""
	else:
		try_again.text = "Try Again!"
		nextscene = ""
	var tween3 := create_tween()
	tween3.tween_property(try_again, "modulate.a", 1, 0)

func buttonpress() -> void:
	try_again.pressed.connect(Globals.resetWater)
	
