extends CharacterBody2D

const SPEED = 300

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimatedSprite2D")
var hurt = false
var attacking = false
var player_in_sight = false

func _ready():
	animation.play("run")

func _physics_process(delta):
	if not hurt:
		if not attacking:
			if not is_on_floor():
				velocity.y += gravity * delta

			if animation.flip_h:
				velocity.x = SPEED
				$Sight/Left.disabled = true
				$Sight/Right.disabled = false
			else:
				velocity.x = -SPEED
				$Sight/Left.disabled = false
				$Sight/Right.disabled = true

			if $RayCast2D.is_colliding() == false:
				animation.flip_h = false
			if is_on_wall():
				animation.flip_h = true
			
			move_and_slide()
	
		if player_in_sight:
			animation.play("attack")

func _on_hurt_box_area_entered(area):
	if area.get_parent().name == "Player" and area.get_parent().attacking and not hurt:
		hurt = true
		animation.play("hurt")

func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "hurt":
		queue_free()
	if animation.animation == "attack":
		attacking = false
		animation.play("run")

func _on_sight_body_entered(body):
	if body.name == "Player":
		player_in_sight = true
		attacking = true

func _on_sight_body_exited(body):
	if body.name == "Player":
		player_in_sight = false

func _on_animated_sprite_2d_frame_changed():
	if animation.animation == "attack":
		if animation.frame == 6:
			if not animation.flip_h:
				$HitBox/Left.disabled = false
			else:
				$HitBox/Right.disabled = false
		else:
			$HitBox/Left.disabled = true
			$HitBox/Right.disabled = true
