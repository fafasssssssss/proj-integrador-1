extends CharacterBody3D
# Script "mestre" do player

enum PLAYER_STATE { IDLE, MOVING, DASHING }

@export var stats : PlayerStats  #referência do objeto que contem os atributos do personagem jogável
var components : Dictionary[String, PlayerComponent] = {} #dicionário com todos os componentes do player, no formato "nome do componente -> componente"
var state : PLAYER_STATE

func _ready() -> void:
	#encontrar os componentes do player na cena e colocar eles certinho no dicionário
	for c in find_child("Components").get_children():
		components.set(c.name, c)
		print(components) #print pra propósitos de debug
	
	#definir o estado padrão do player como idle
	state = PLAYER_STATE.IDLE

func check_state() -> String: return PLAYER_STATE.keys()[state]

func can_dash() -> bool:
	if components["Dash"]: return components["Dash"].can_dash
	else: return false


func _on_hurtbox_hurt(damage: Variant) -> void:
	stats.hp -= damage
	if stats.hp <= 0: print("played died lol")
