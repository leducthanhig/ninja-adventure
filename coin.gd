extends Area2D

func _ready():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body.name == "Player":
		body.coin += 1
		$AnimatedSprite2D.play("disappear")
		if Data.sound:
			$AudioStreamPlayer2D.play()
		

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "disappear":
		queue_free()
