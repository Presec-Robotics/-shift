extends CharacterBody2D

@onready var speed = 200

func _ready():
	set_as_top_level(true)

func _physics_process(_delta) -> void:
	velocity.x = -speed
	velocity.y = 0

	move_and_slide()

func _on_timer_timeout():
	queue_free()
