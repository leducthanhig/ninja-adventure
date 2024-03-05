extends CharacterBody2D

const SPEED = 300
const JUMP_VELOCITY = -500

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimatedSprite2D")
@onready var doubleJump = 0
var attacking = false
var dead = false
var finishedDead = false
var coin = 0
@onready var max_coins = get_tree().get_nodes_in_group("Coins").size()

func _physics_process(delta):
	if not dead:
		if not attacking:
			if Input.is_action_just_pressed("ui_up") and doubleJump < 2:
				doubleJump += 1
				velocity.y = JUMP_VELOCITY

			var direction = Input.get_axis("ui_left", "ui_right")
			if direction != 0:
				velocity.x = direction * SPEED
				animation.play("run")
				if direction == 1:
					animation.flip_h = false
				else:
					animation.flip_h = true
			else:
				velocity.x = 0
				animation.play("idle")

		if not is_on_floor():
			velocity.y += gravity * delta
		else:
			doubleJump = 0

		if Input.is_action_just_pressed("ui_accept"):
			attacking = true
			velocity.x = 0
			animation.play("attack")
			if Data.sound:
				$Attack.play()

		move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "attack":
		attacking = false
	if animation.animation == "dead":
		finishedDead = true

func _on_animated_sprite_2d_frame_changed():
	if animation.animation == "attack":
		if animation.frame == 5:
			if animation.flip_h:
				$HitBox/CollisionShape2DLeft.disabled = false
			else:
				$HitBox/CollisionShape2DRight.disabled = false
		else:
			$HitBox/CollisionShape2DLeft.disabled = true
			$HitBox/CollisionShape2DRight.disabled = true

func _on_hurt_box_area_entered(area):
	var tmp = area.get_parent()
	if (area.name == "DeadArea" or (area.name == "HitBox" and tmp.name != "Player" and not tmp.hurt)) and not dead:
		dead = true
		animation.play("dead")
		if Data.sound:
			$Hurt.play()
