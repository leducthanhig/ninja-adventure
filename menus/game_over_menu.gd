extends Control

func _ready():
	if Data.sound:
		$Click.volume_db = 0
	else:
		$Click.volume_db = -80

func _process(delta):
	if get_parent().get_node("Player").finishedDead:
		show()
		get_tree().paused = true

func _on_retry_pressed():
	$Click.play()
	await $Click.finished
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	$Click.play()
	await $Click.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
