extends Control

func _ready():
	if Data.sound:
		$Click.volume_db = 0
	else:
		$Click.volume_db = -80

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		hide()
		get_parent().get_node("Frame").show()

func _on_texture_button_pressed():
	$Click.play()
	hide()
	get_parent().get_node("Frame").show()
