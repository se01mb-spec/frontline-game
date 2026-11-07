extends CharacterBody2D

signal health_changed(current_health: int, maximum_health: int)
signal died

@export var move_speed: float = 260.0
@export var max_health: int = 100

var health: int
var invulnerability_timer := 0.0
var is_dead := false
var touch_direction := Vector2.ZERO
var facing_direction := Vector2.UP
var movement_phase := 0.0
var was_moving := false

func _ready() -> void:
	add_to_group("player")
	health = max_health
	health_changed.emit(health, max_health)
	queue_redraw()

func _physics_process(_delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return
	invulnerability_timer = maxf(0.0, invulnerability_timer - delta)
	var keyboard_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := keyboard_direction if keyboard_direction.length() > 0.1 else touch_direction
	if direction.length() > 0.08:
		facing_direction = direction.normalized()
	velocity = direction.limit_length(1.0) * move_speed
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

func _process(delta: float) -> void:
	if invulnerability_timer > 0.0:
		modulate = Color(1.0, 0.55, 0.55, 1.0)
	else:
		modulate = Color.WHITE

	var moving := velocity.length() > 8.0 and not is_dead
	if moving:
		movement_phase += delta * 12.0 * clampf(velocity.length() / move_speed, 0.35, 1.0)
		was_moving = true
		queue_redraw()
	elif was_moving:
		was_moving = false
		queue_redraw()

func _draw() -> void:
	var moving := velocity.length() > 8.0 and not is_dead
	var stride := sin(movement_phase) * 4.0 if moving else 0.0
	var bob := absf(sin(movement_phase * 2.0)) * 1.8 if moving else 0.0
	var rotation_angle := facing_direction.angle() + PI * 0.5
	draw_set_transform(Vector2(0.0, bob), rotation_angle, Vector2.ONE)

	# Soft ground shadow.
	draw_circle(Vector2(0, 14), 13.0, Color(0.02, 0.03, 0.025, 0.38))

	# Alternating boots and legs create a readable walking/running cycle.
	draw_line(Vector2(-6, 10), Vector2(-7 - stride, 23), Color("202923"), 6.0, true)
	draw_line(Vector2(6, 10), Vector2(7 + stride, 23), Color("202923"), 6.0, true)
	draw_line(Vector2(-7 - stride, 23), Vector2(-12 - stride, 24), Color("111a17"), 5.0, true)
	draw_line(Vector2(7 + stride, 23), Vector2(12 + stride, 24), Color("111a17"), 5.0, true)

	# Backpack and torso.
	draw_rect(Rect2(-11, -2, 22, 19), Color("354b3d"), true)
	draw_rect(Rect2(-9, -1, 18, 17), Color("667653"), true)
	draw_rect(Rect2(-4, 1, 8, 12), Color("4b5d43"), true)
	draw_rect(Rect2(-13, 0, 5, 11), Color("4b5d43"), true)
	draw_rect(Rect2(8, 0, 5, 11), Color("4b5d43"), true)

	# Arms swing opposite to the legs.
	draw_line(Vector2(-10, 1), Vector2(-15 - stride * 0.55, 10), Color("c39b69"), 5.0, true)
	draw_line(Vector2(10, 1), Vector2(15 + stride * 0.55, 10), Color("c39b69"), 5.0, true)

	# Head, helmet and a small visor mark.
	draw_circle(Vector2(0, -10), 8.5, Color("bd9466"))
	draw_arc(Vector2(0, -12), 9.0, PI, TAU, 24, Color("263b30"), 5.0, true)
	draw_line(Vector2(-5, -9), Vector2(5, -9), Color("e0c28e"), 1.5, true)

	# Compact rifle silhouette, kept deliberately stylized.
	draw_line(Vector2(9, 3), Vector2(12, -18), Color("202723"), 4.0, true)
	draw_line(Vector2(12, -18), Vector2(12, -24), Color("111816"), 2.0, true)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
