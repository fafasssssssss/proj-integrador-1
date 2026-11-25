extends CharacterBody3D
class_name PlayerMaster
# Script "mestre" do player

enum PLAYER_STATE { IDLE, MOVING, DASHING, STUNNED }
var state:PLAYER_STATE

var base_stats:Stats
var stats:Stats
var buffs:Array[StatusDef]
var debuffs:Array[StatusDef]

@export var parts:Array[PlayerComponent]

var can_move:bool = true
var can_dash:bool = true

signal state_changed(new_state)

func _ready() -> void:
	base_stats = Stats.new()
	stats = Stats.new()
	stats.hp = stats.max_hp
	#encontrar os componentes do player na cena e colocar eles certinho no dicionário
	if parts.size() > 0:
		for p in parts:
			p.player = self
			p.player_ready()
	print(parts) #print pra propósitos de debug
	
	#definir o estado padrão do player como idle
	state = PLAYER_STATE.IDLE

func get_state() -> String: return PLAYER_STATE.keys()[state]

func set_state(new_state:String) -> void:
	state = PLAYER_STATE.get(new_state)
	state_changed.emit(new_state)

func _on_hurtbox_hurt(damage: Variant) -> void:
	stats.hp -= damage
	if stats.hp <= 0: print("played died lol")

func get_part(part_name:String) -> PlayerComponent:
	for p in parts:
		if p.name == part_name: return p
	return null
