extends HSlider
@onready var sfx_slider = %SFXSlider
@onready var sfx_music_button = %SFXMusicButton
var soundicon = preload("res://Assets/soundicon.svg")
var soundiconmuted = preload("res://Assets/soundiconmuted.svg")

var bus := AudioServer.get_bus_index("SFX")

func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(bus))
	sfx_music_button.pressed.connect(musicds)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))

func musicds() -> void:
	if 	AudioServer.is_bus_mute(bus) == true:
		sfx_music_button.texture_normal = soundicon
		AudioServer.set_bus_mute(bus, 0)
		print("unmute")
	elif  	AudioServer.is_bus_mute(bus) == false:
		sfx_music_button.texture_normal = soundiconmuted
		AudioServer.set_bus_mute(bus, 1)
		print("mute")
