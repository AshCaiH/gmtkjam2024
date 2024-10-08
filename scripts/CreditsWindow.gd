extends ColorRect
@onready var credits_window = %CreditsWindow
@onready var credits_close_button = %"Credits Close Button"
@onready var credits = %Credits


# Called when the node enters the scene tree for the first time.
func _ready():
	closecreditswindow()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func closecreditswindow() -> void:
	credits_close_button.pressed.connect(func() -> void: credits_window.visible = false)
	
