class_name StateMachine
extends Node
## 状态机节点

## 初始状态
@export var initial_state: StateBase

## 是否运行状态机 
var _started: bool = false
##状态字典
var _states: Dictionary = {}
## 当前状态
var current_state: StateBase = null
## 当前状态运行时间
var current_state_run_time: float = 0.0
## 下一状态, 仅在exit方法中有效
var next_state: StateBase = null
## 历史状态
var _history_states: Array[String] = []


func _ready() -> void:
	for state: StateBase in get_children():
		state.state_machine = self
		state.character = owner
		_states[state.name] = state
	
	if initial_state:
		_history_states.append(initial_state.name)
		initial_state.enter()
		current_state = initial_state


func _physics_process(delta: float) -> void:
	if _started and current_state:
		current_state_run_time += delta
		current_state.physics_update(delta)
		

func _process(delta: float) -> void:
	if _started and current_state:
		current_state.update(delta)
		

func change_state(from: StateBase, to: String) -> void:
	var cs: StateBase = current_state
	current_state = null
	
	if cs != from:
		print("error: current_state与from不一致, from: ", from, " current_state: ", cs)
		return
	
	var new_state: StateBase = _states.get(to)
	if !new_state:
		print("error: 不存在状态: ", to)
		return
	
	next_state = new_state
	cs.exit()
	next_state = null
	_history_states.append(new_state.name)
	new_state.enter()
	current_state_run_time = 0.0
	current_state = new_state


func start() -> void:
	_started = true

func stop() -> void:
	_started = false
	
