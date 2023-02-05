extends BaseButton

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", _on_mouse_entered)
	connect("pressed", _on_pressed)
	pass # Replace with function body.


func _on_mouse_entered():
	if !disabled:
		Audio.play_button_in()

func _on_pressed():
	if toggle_mode:
		Audio.play_switch()
	else:
		Audio.play_select()
