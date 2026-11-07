extends Node2D

const PLAYER_SCENE: PackedScene = preload("res://scenes/player.tscn")
const MAP_SIZE := Vector2(1280.0, 720.0)

var player: CharacterBody2D
var objective_reached := false
var objective_label: Label

func _ready() -> void:
	_setup_test_input()
	player = PLAYER_SCENE.instantiate()
	player.position = Vector2(150.0, 360.0)
	add_child(player)
	objective_label = Label.new()
	objective_label.position = Vector2(28.0, 24.0)
	objective_label.add_theme_font_size_override("font_size", 24)
	objective_label.add_theme_color_override("font_color", Color("f3e8c5"))
	objective_label.text = "OBJECTIVE: Reach the safe zone"
	add_child(objective_label)
	queue_redraw()

func _setup_test_input() -> void:
	_add_key_action("move_left", KEY_A)
	_add_key_action("move_left", KEY_LEFT)
	_add_key_action("move_right", KEY_D)
	_add_key_action("move_right", KEY_RIGHT)
	_add_key_action("move_up", KEY_W)
	_add_key_action("move_up", KEY_UP)
	_add_key_action("move_down", KEY_S)
	_add_key_action("move_down", KEY_DOWN)

func _add_key_action(action_name: String, key_code: Key) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
	var event := InputEventKey.new()
	event.physical_keycode = key_code
	if not InputMap.action_has_event(action_name, event):
		InputMap.action_add_event(action_name, event)

func _process(_delta: float) -> void:
	if player == null or objective_reached:
		return
	if player.position.distance_to(Vector2(1110.0, 360.0)) < 42.0:
		objective_reached = true
		objective_label.text = "OBJECTIVE COMPLETE — You reached safety"
		queue_redraw()

func _draw() -> void:
	# Simple placeholder terrain, intentionally drawn in code to avoid external assets.
	draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color("343d36"), true)
	for x in range(0, 1281, 80):
		draw_line(Vector2(x, 0), Vector2(x, 720), Color(0.75, 0.78, 0.7, 0.07), 1.0)
	for y in range(0, 721, 80):
		draw_line(Vector2(0, y), Vector2(1280, y), Color(0.75, 0.78, 0.7, 0.07), 1.0)
	# Placeholder cover objects for scale and navigation.
	draw_rect(Rect2(390, 190, 120, 55), Color("55594d"), true)
	draw_rect(Rect2(720, 455, 170, 48), Color("55594d"), true)
	# Safe-zone objective marker.
	var target := Vector2(1110.0, 360.0)
	draw_arc(target, 34.0, 0.0, TAU, 48, Color("e6c75a"), 3.0)
	draw_arc(target, 22.0, 0.0, TAU, 48, Color("e6c75a"), 2.0)
	draw_line(target + Vector2(-45, 0), target + Vector2(45, 0), Color("e6c75a"), 2.0)
	draw_line(target + Vector2(0, -45), target + Vector2(0, 45), Color("e6c75a"), 2.0)
