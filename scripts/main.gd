extends Node2D

const PLAYER_SCENE: PackedScene = preload("res://scenes/player.tscn")
const ENEMY_SCENE: PackedScene = preload("res://scenes/enemy.tscn")
const MAP_SIZE := Vector2(1920.0, 1080.0)
const OBJECTIVE_POSITION := Vector2(1740.0, 540.0)

var player: CharacterBody2D
var objective_reached := false
var game_over := false
var objective_label: Label
var health_label: Label
var result_label: Label

func _ready() -> void:
	_setup_test_input()
	_create_world_boundaries()
	_create_obstacle(Rect2(430, 260, 150, 70))
	_create_obstacle(Rect2(820, 650, 210, 64))
	_create_obstacle(Rect2(1180, 300, 90, 190))
	_create_obstacle(Rect2(1450, 760, 180, 70))

	player = PLAYER_SCENE.instantiate()
	player.position = Vector2(150.0, 540.0)
	add_child(player)
	player.connect("died", _on_player_died)

	var camera := Camera2D.new()
	camera.name = "FollowCamera"
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 5.0
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = int(MAP_SIZE.x)
	camera.limit_bottom = int(MAP_SIZE.y)
	player.add_child(camera)
	camera.make_current()

	_spawn_hostile(Vector2(700, 180))
	_spawn_hostile(Vector2(1080, 850))
	_spawn_hostile(Vector2(1510, 420))

	_create_hud()
	_create_touch_controls()
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

func _create_world_boundaries() -> void:
	var thickness := 48.0
	_create_obstacle(Rect2(-thickness, -thickness, MAP_SIZE.x + thickness * 2.0, thickness))
	_create_obstacle(Rect2(-thickness, MAP_SIZE.y, MAP_SIZE.x + thickness * 2.0, thickness))
	_create_obstacle(Rect2(-thickness, 0, thickness, MAP_SIZE.y))
	_create_obstacle(Rect2(MAP_SIZE.x, 0, thickness, MAP_SIZE.y))

func _create_obstacle(rect: Rect2) -> void:
	var body := StaticBody2D.new()
	body.position = rect.position + rect.size / 2.0
	var shape_node := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = rect.size
	shape_node.shape = shape
	body.add_child(shape_node)
	add_child(body)

func _spawn_hostile(spawn_position: Vector2) -> void:
	var hostile := ENEMY_SCENE.instantiate()
	hostile.position = spawn_position
	add_child(hostile)

func _create_hud() -> void:
	var hud := CanvasLayer.new()
	hud.name = "HUD"
	add_child(hud)

	objective_label = Label.new()
	objective_label.position = Vector2(28, 24)
	objective_label.add_theme_font_size_override("font_size", 24)
	objective_label.add_theme_color_override("font_color", Color("f3e8c5"))
	objective_label.text = "MISSION 01  |  REACH THE SAFE ZONE"
	hud.add_child(objective_label)

	health_label = Label.new()
	health_label.position = Vector2(28, 62)
	health_label.add_theme_font_size_override("font_size", 21)
	health_label.add_theme_color_override("font_color", Color("e7b6a8"))
	hud.add_child(health_label)

	result_label = Label.new()
	result_label.set_anchors_preset(Control.PRESET_CENTER)
	result_label.position = Vector2(-250, -60)
	result_label.size = Vector2(500, 70)
	result_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	result_label.add_theme_font_size_override("font_size", 30)
	result_label.add_theme_color_override("font_color", Color("f3e8c5"))
	result_label.visible = false
	hud.add_child(result_label)

	var retry_button := Button.new()
	retry_button.text = "RESTART MISSION"
	retry_button.set_anchors_preset(Control.PRESET_CENTER)
	retry_button.position = Vector2(-100, 28)
	retry_button.custom_minimum_size = Vector2(200, 54)
	retry_button.visible = false
	retry_button.pressed.connect(_restart_mission)
	hud.add_child(retry_button)
	result_label.set_meta("retry_button", retry_button)

func _create_touch_controls() -> void:
	var layer := CanvasLayer.new()
	layer.name = "TouchControls"
	add_child(layer)
	_create_direction_button(layer, "◀", "move_left", Vector2(28, -112))
	_create_direction_button(layer, "▲", "move_up", Vector2(118, -202))
	_create_direction_button(layer, "▼", "move_down", Vector2(118, -112))
	_create_direction_button(layer, "▶", "move_right", Vector2(208, -112))

func _create_direction_button(parent: CanvasLayer, caption: String, action_name: String, button_position: Vector2) -> void:
	var button := Button.new()
	button.text = caption
	button.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	button.custom_minimum_size = Vector2(78, 78)
	button.size = Vector2(78, 78)
	button.position = button_position
	button.add_theme_font_size_override("font_size", 30)
	button.modulate = Color(1, 1, 1, 0.82)
	button.button_down.connect(func(): Input.action_press(action_name))
	button.button_up.connect(func(): Input.action_release(action_name))
	parent.add_child(button)

func _process(_delta: float) -> void:
	if player == null:
		return
	health_label.text = "HEALTH: %d / %d" % [int(player.get("health")), int(player.get("max_health"))]
	if game_over or objective_reached:
		return
	if player.position.distance_to(OBJECTIVE_POSITION) < 48.0:
		objective_reached = true
		objective_label.text = "MISSION COMPLETE"
		_show_result("YOU REACHED SAFETY")

func _on_player_died() -> void:
	game_over = true
	objective_label.text = "MISSION FAILED"
	_show_result("MISSION FAILED — SOLDIER DOWN")

func _show_result(message: String) -> void:
	result_label.text = message
	result_label.visible = true
	var retry_button := result_label.get_meta("retry_button") as Button
	retry_button.visible = true

func _restart_mission() -> void:
	get_tree().reload_current_scene()

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color("343d36"), true)
	for x in range(0, int(MAP_SIZE.x) + 1, 80):
		draw_line(Vector2(x, 0), Vector2(x, MAP_SIZE.y), Color(0.75, 0.78, 0.7, 0.07), 1)
	for y in range(0, int(MAP_SIZE.y) + 1, 80):
		draw_line(Vector2(0, y), Vector2(MAP_SIZE.x, y), Color(0.75, 0.78, 0.7, 0.07), 1)
	# Visual cover is paired with matching StaticBody2D collision shapes.
	draw_rect(Rect2(430, 260, 150, 70), Color("55594d"), true)
	draw_rect(Rect2(820, 650, 210, 64), Color("55594d"), true)
	draw_rect(Rect2(1180, 300, 90, 190), Color("55594d"), true)
	draw_rect(Rect2(1450, 760, 180, 70), Color("55594d"), true)
	draw_arc(OBJECTIVE_POSITION, 38, 0, TAU, 48, Color("e6c75a"), 3)
	draw_arc(OBJECTIVE_POSITION, 24, 0, TAU, 48, Color("e6c75a"), 2)
	draw_line(OBJECTIVE_POSITION + Vector2(-48, 0), OBJECTIVE_POSITION + Vector2(48, 0), Color("e6c75a"), 2)
	draw_line(OBJECTIVE_POSITION + Vector2(0, -48), OBJECTIVE_POSITION + Vector2(0, 48), Color("e6c75a"), 2)
