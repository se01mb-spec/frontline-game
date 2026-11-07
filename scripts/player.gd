extends CharacterBody2D

signal health_changed(current_health: int, maximum_health: int)
signal died

@export var move_speed: float = 260.0
@export var max_health: int = 100

@onready var character_sprite: Sprite2D = $CharacterSprite

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

func _physics_process(delta: float) -> void:
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
		character_sprite.modulate = Color(1.0, 0.55, 0.55, 1.0)
	else:
		character_sprite.modulate = Color.WHITE

	# The supplied sheet has a clean hero pose, not animation frames yet.
	# Keep the cutout readable while giving movement a subtle body bob.
	var moving := velocity.length() > 8.0 and not is_dead
	character_sprite.rotation = facing_direction.angle() + PI * 0.5
	if moving:
		movement_phase += delta * 12.0 * clampf(velocity.length() / move_speed, 0.35, 1.0)
		character_sprite.position.y = -5.0 - absf(sin(movement_phase * 2.0)) * 1.5
		was_moving = true
	elif was_moving:
		character_sprite.position.y = -5.0
		was_moving = false
