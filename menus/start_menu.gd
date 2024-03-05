extends Control

func _ready():
	if Data.sound:
		$Click.volume_db = 0
	else:
		$Click.volume_db = -80
	
	var level = str(get_parent().name)[-1]
	$Title.text = "Level " + level
	show()
	get_tree().paused = true

func _on_play_pressed():
	$Click.play()
	get_parent().get_node("PauseMenu").show()
	hide()
	get_tree().paused = false

func _on_main_menu_pressed():
	$Click.play()
	await $Click.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
