extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = get_viewport_rect().size/2
	self.position.y = 530


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
