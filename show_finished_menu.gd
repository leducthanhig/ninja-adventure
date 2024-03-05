extends Area2D

var finished = false

func _on_body_entered(body):
	if body.name == "Player":
		get_parent().get_node("PauseMenu").hide()
		finished = true
		var level = str(get_parent().name)
		var score = min(int(float(body.coin) / body.max_coins * 100), 100)
		PlayerData.scores[level] = max(PlayerData.scores[level], score, 1)
		PlayerData.level = max(int(level[-1]), PlayerData.level)
		
		$FinishedMenu/HBoxContainer/Gold1.show()
		$FinishedMenu/HBoxContainer/GoldDisable1.hide()
		if score >= 67:
			$FinishedMenu/HBoxContainer/Gold2.show()
			$FinishedMenu/HBoxContainer/GoldDisable2.hide()
		if score == 100:
			$FinishedMenu/HBoxContainer/Gold3.show()
			$FinishedMenu/HBoxContainer/GoldDisable3.hide()
		
		Data.save_data()
