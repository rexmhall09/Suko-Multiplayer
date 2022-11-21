extends Node

const DEAFULT_PORT = 28958
const MAX_CLIENTS = 10

var server = null
var client = null

var ip_address = ""

func _ready() -> void:
	if OS.get_name() == "Windows":
		ip_address = IP.get_local_addresses()[3]
	elif OS.get_name() == "Android":
		ip_address = IP.get_local_addresses()[0]
	else:
		ip_address = IP.get_local_addresses()[3]
		
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			ip_address = ip
			
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func create_server() -> void:
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEAFULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)

func join_server() -> void:
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, DEAFULT_PORT)
	get_tree().set_network_peer(client)

func _connected_to_server() -> void:
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEAFULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)

func _server_disconnected() -> void:
	print("server disconnected")
