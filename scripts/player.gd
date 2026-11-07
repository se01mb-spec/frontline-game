extends CharacterBody2D

@export var move_speed: float = 260.0

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed
	move_and_slide()

func _draw() -> void:
	# Temporary original placeholder silhouette; replace with licensed/original art later.
	draw_circle(Vector2.ZERO, 17.0, Color("d8b56b"))
	draw_circle(Vector2(0, -3), 8.0, Color("293b32"))
	draw_rect(Rect2(-10, 5, 20, 15), Color("526b4f"), true)
	draw_line(Vector2(-8, 17), Vector2(-13, 25), Color("202a25"), 4.0)
	draw_line(Vector2(8, 17), Vector2(13, 25), Color("202a25"), 4.0)
