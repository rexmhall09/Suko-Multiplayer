extends Control

onready var multiplater_config_ui = $Multiplayer_Configure
onready var server_ip_address = $Multiplayer_Configure/Enter_Ip_Address

onready var device_ip_address = $CanvasLayer/Device_Ip_Address

func _ready() -> void:
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	
	device_ip_address.text = Network.ip_address

func _player_connected(id) -> void:
	print("Player " + str(id) + " has connected")

func _player_disconnected(id) -> void:
	print("Player " + str(id) + " has disconnected")

func _on_Create_Server_pressed():
	multiplater_config_ui.hide()
	Network.create_server()


func _on_Join_Server_pressed():
	if server_ip_address.text != "":
		multiplater_config_ui.hide()
		Network.ip_address = server_ip_address.text
		Network.join_server()
