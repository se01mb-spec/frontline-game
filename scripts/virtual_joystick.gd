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
	draw_circle(center, radius + 7.0, Color(0.02, 0.04, 0.04, 0.28))
	draw_circle(center, radius, Color(0.10, 0.15, 0.14, 0.72))
	draw_arc(center, radius, 0.0, TAU, 64, Color(0.83, 0.78, 0.60, 0.72), 3.0, true)
	draw_circle(center, radius * DEADZONE, Color(0.85, 0.82, 0.70, 0.10))
	var knob_center := center + _knob_offset
	draw_circle(knob_center, KNOB_RADIUS + 3.0, Color(0.02, 0.03, 0.03, 0.38))
	draw_circle(knob_center, KNOB_RADIUS, Color(0.83, 0.68, 0.38, 0.94))
	draw_arc(knob_center, KNOB_RADIUS - 4.0, 0.0, TAU, 48, Color(1.0, 0.91, 0.68, 0.85), 2.0, true)
