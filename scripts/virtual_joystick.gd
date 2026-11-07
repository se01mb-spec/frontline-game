extends Control

signal direction_changed(direction: Vector2)

var _active_touch_index := -1
var _direction := Vector2.ZERO
var _knob_offset := Vector2.ZERO
var _mouse_active := false

const KNOB_RADIUS := 31.0
const DEADZONE := 0.12

func _ready() -> void:
	custom_minimum_size = Vector2(190.0, 190.0)
	size = custom_minimum_size
	mouse_filter = Control.MOUSE_FILTER_STOP
	focus_mode = Control.FOCUS_NONE
	queue_redraw()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and _active_touch_index == -1:
			_active_touch_index = event.index
			_update_from_position(event.position)
			accept_event()
		elif not event.pressed and event.index == _active_touch_index:
			_active_touch_index = -1
			_reset_stick()
			accept_event()
	elif event is InputEventScreenDrag and event.index == _active_touch_index:
		_update_from_position(event.position)
		accept_event()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_mouse_active = true
			_update_from_position(event.position)
		else:
			_mouse_active = false
			_reset_stick()
		accept_event()
	elif event is InputEventMouseMotion and _mouse_active:
		_update_from_position(event.position)
		accept_event()

func _update_from_position(local_position: Vector2) -> void:
	var center := size * 0.5
	var radius := minf(size.x, size.y) * 0.40
	var offset := local_position - center
	_knob_offset = offset.limit_length(radius)
	_direction = _knob_offset / radius
	if _direction.length() < DEADZONE:
		_direction = Vector2.ZERO
	direction_changed.emit(_direction)
	queue_redraw()

func _reset_stick() -> void:
	_direction = Vector2.ZERO
	_knob_offset = Vector2.ZERO
	direction_changed.emit(_direction)
	queue_redraw()

func _draw() -> void:
	var center := size * 0.5
	var radius := minf(size.x, size.y) * 0.40
	var active := _direction.length() > 0.0
	var rim_color := Color("e6c75a") if active else Color("b9b59d")

	# Layered tactical base with a subtle metallic rim.
	draw_circle(center + Vector2(0, 5), radius + 10.0, Color(0.01, 0.025, 0.025, 0.32))
	draw_circle(center, radius + 7.0, Color("18231f"))
	draw_circle(center, radius + 2.0, Color("66705c"))
	draw_circle(center, radius - 2.0, Color(0.07, 0.12, 0.105, 0.94))
	draw_arc(center, radius + 3.0, 0.0, TAU, 72, rim_color, 2.5, true)
	draw_arc(center, radius - 9.0, 0.0, TAU, 72, Color(0.82, 0.79, 0.65, 0.22), 1.0, true)

	# Eight small orientation marks make the control read as a joystick.
	for i in range(8):
		var angle := TAU * float(i) / 8.0
		var inner := center + Vector2.from_angle(angle) * (radius - 17.0)
		var outer := center + Vector2.from_angle(angle) * (radius - 11.0)
		draw_line(inner, outer, Color(0.88, 0.84, 0.70, 0.48), 2.0, true)

	# Direction tether and center marker.
	var knob_center := center + _knob_offset
	if active:
		draw_line(center, knob_center, Color("e6c75a"), 4.0, true)
	draw_circle(center, 5.0, Color(0.90, 0.84, 0.62, 0.62))

	# Raised thumb pad.
	draw_circle(knob_center + Vector2(0, 3), KNOB_RADIUS + 4.0, Color(0.01, 0.02, 0.02, 0.42))
	draw_circle(knob_center, KNOB_RADIUS + 1.0, Color("26352e"))
	draw_circle(knob_center, KNOB_RADIUS - 3.0, Color("c89a4b"))
	draw_arc(knob_center, KNOB_RADIUS - 7.0, PI, TAU, 40, Color("f4d58a", 0.9), 2.0, true)
	draw_circle(knob_center, 5.0, Color("f0d18a", 0.78))
