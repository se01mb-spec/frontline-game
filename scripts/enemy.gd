extends CharacterBody2D

@export var move_speed: float = 92.0
@export var contact_damage: int = 12
@export var contact_distance: float = 34.0
@export var attack_interval: float = 1.15

var target: CharacterBody2D
var attack_cooldown := 0.0

func _ready() -> void:
	add_to_group("hostile")

func _physics_process(delta: float) -> void:
	attack_cooldown = maxf(0.0, attack_cooldown - delta)
	if not is_instance_valid(target):
		var found := get_tree().get_first_node_in_group("player")
		if found is CharacterBody2D:
			target = found as CharacterBody2D
		else:
			velocity = Vector2.ZERO
			return

	var offset := target.global_position - global_position
	if offset.length() > contact_distance:
		velocity = offset.normalized() * move_speed
	else:
		velocity = Vector2.ZERO
		if attack_cooldown <= 0.0 and target.has_method("take_damage"):
			target.call("take_damage", contact_damage)
			attack_cooldown = attack_interval
	move_and_slide()

func _draw() -> void:
	# Distinct red-brown silhouette marks a hostile unit.
	draw_circle(Vector2.ZERO, 16.0, Color("a84b3d"))
	draw_circle(Vector2(0, -3), 7.0, Color("302c2a"))
	draw_rect(Rect2(-9, 5, 18, 14), Color("70433b"), true)
	draw_line(Vector2(-7, 16), Vector2(-12, 23), Color("302c2a"), 4)
	draw_line(Vector2(7, 16), Vector2(12, 23), Color("302c2a"), 4)
