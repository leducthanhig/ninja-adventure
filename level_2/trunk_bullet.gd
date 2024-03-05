extends CharacterBody2D

const speed = 1000

func _physics_process(delta):
	velocity.x = speed
	
	if is_on_wall():
		queue_free()
	
	move_and_slide()
	
func start_at(pos):
	position = pos

func _on_hit_box_body_entered(body):
	if body.name == "Player":
		queue_free()
