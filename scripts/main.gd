extends Node2D

const PLAYER_SCENE: PackedScene = preload("res://scenes/player.tscn")
const MAP_SIZE := Vector2(1280.0, 720.0)

var player: CharacterBody2D
var objective_reached := false

func _ready() -> void:
	player = PLAYER_SCENE.instantiate()
	player.position = Vector2(150.0, 360.0)
	add_child(player)
	queue_redraw()

func _process(_delta: float) -> void:
	if player == null or objective_reached:
		return
	if player.position.distance_to(Vector2(1110.0, 360.0)) < 42.0:
		objective_reached = true
		queue_redraw()

func _draw() -> void:
	# Simple placeholder terrain, intentionally drawn in code to avoid external assets.
	draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color("343d36"), true)
	for x in range(0, 1281, 80):
		draw_line(Vector2(x, 0), Vector2(x, 720), Color(0.75, 0.78, 0.7, 0.07), 1.0)
	for y in range(0, 721, 80):
		draw_line(Vector2(0, y), Vector2(1280, y), Color(0.75, 0.78, 0.7, 0.07), 1.0)
	# Ruined cover / obstacles for visual scale only.
	draw_rect(Rect2(390, 190, 120, 55), Color("55594d"), true)
	draw_rect(Rect2(720, 455, 170, 48), Color("55594d"), true)
	# Safe-zone objective marker.
	var target := Vector2(1110.0, 360.0)
	draw_arc(target, 34.0, 0.0, TAU, 48, Color("e6c75a"), 3.0)
	draw_arc(target, 22.0, 0.0, TAU, 48, Color("e6c75a"), 2.0)
	draw_line(target + Vector2(-45, 0), target + Vector2(45, 0), Color("e6c75a"), 2.0)
	draw_line(target + Vector2(0, -45), target + Vector2(0, 45), Color("e6c75a"), 2.0)
	if objective_reached:
		draw_rect(Rect2(390, 35, 500, 70), Color(0.08, 0.1, 0.08, 0.9), true)
