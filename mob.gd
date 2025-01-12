extends CharacterBody2D

const SPEED = 300
var health = 3
@onready var player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		smoke.rotation = randi_range(0, 360)
		get_parent().add_child(smoke)
		smoke.global_position = global_position
