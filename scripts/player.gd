extends CharacterBody2D

signal health_changed(current_health: int, maximum_health: int)
signal died

@export var move_speed: float = 260.0
@export var max_health: int = 100

var health: int
var invulnerability_timer := 0.0
var is_dead := false
var touch_direction := Vector2.ZERO

func _ready() -> void:
	add_to_group("player")
	health = max_health
	health_changed.emit(health, max_health)

func _physics_process(delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return
	invulnerability_timer = maxf(0.0, invulnerability_timer - delta)
	var keyboard_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := keyboard_direction if keyboard_direction.length() > 0.1 else touch_direction
	velocity = direction * move_speed
	move_and_slide()

func set_touch_direction(direction: Vector2) -> void:
	touch_direction = direction.limit_length(1.0)

func take_damage(amount: int) -> void:
	if is_dead or invulnerability_timer > 0.0:
		return
	health = maxi(0, health - amount)
	invulnerability_timer = 0.7
	health_changed.emit(health, max_health)
	if health <= 0:
		is_dead = true
		died.emit()

func _process(_delta: float) -> void:
	if invulnerability_timer > 0.0:
		modulate = Color(1.0, 0.55, 0.55, 1.0)
	else:
		modulate = Color.WHITE

func _draw() -> void:
	# Original temporary top-down soldier silhouette.
	draw_circle(Vector2.ZERO, 17.0, Color("d8b56b"))
	draw_circle(Vector2(0, -3), 8, Color("293b32"))
	draw_rect(Rect2(-10, 5, 20, 15), Color("526b4f"), true)
	draw_line(Vector2(-8, 17), Vector2(-13, 25), Color("202a25"), 4)
	draw_line(Vector2(8, 17), Vector2(13, 25), Color("202a25"), 4)
