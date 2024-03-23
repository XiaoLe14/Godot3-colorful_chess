extends Node2D

var myId := -1
var myName := ''
var server_ip
var server_port
var gameStarting = false
var playerlist
var host := NetworkedMultiplayerENet.new()
var p1 = {
	"id":-1,
	"name":"0",
	"color":""
}
var p2 = {
	"id":-1,
	"name":"0",
	"color":""
}
var p3 = {
	"id":-1,
	"name":"0",
	"color":""
}
var p4 = {
	"id":-1,
	"name":"0",
	"color":""
}
remote var players = [p1,p2,p3,p4]
remote var chats = ""

func _ready() -> void:
	print(self.get_tree().network_peer)
	self.get_tree().connect('network_peer_connected', self, '_onNewPlayerConnected')
	self.get_tree().connect('network_peer_disconnected', self, '_onPlayerDisconnected')
	self.get_tree().connect('server_disconnected', self, '_onServerDisconnected')
	self.get_tree().connect('connected_to_server', self, '_onConnectionSuccess')
	self.get_tree().connect('connection_failed', self, '_onConnectionFail')

func _process(delta):
	myName = $UI/MainUI/PlayerName.text
	server_ip = $UI/MainUI/IP.text
	server_port = $UI/MainUI/Port.text
	if get_tree().is_network_server():
		rset("players",players)
		rset("chats",chats)
	if not players[0].id == -1:
		$"UI/WatingUI/1".text = players[0].name
	else:
		$"UI/WatingUI/1".text = "等待中"
	if not players[1].id == -1:
		$"UI/WatingUI/2".text = players[1].name
	else:
		$"UI/WatingUI/2".text = "等待中"
	if not players[2].id == -1:
		$"UI/WatingUI/3".text = players[2].name
	else:
		$"UI/WatingUI/3".text = "等待中"
	if not players[3].id == -1:
		$"UI/WatingUI/4".text = players[3].name
	else:
		$"UI/WatingUI/4".text = "等待中"
	$UI/WatingUI/Chat.text = chats
func wrong(why):
	$UI/Wrong/WrongTimer.start()
	$UI/Wrong/Label.text = why
	$UI/Wrong.show()
func _on_createServer_pressed():
	if not $UI/MainUI/PlayerName.text == "" and not $UI/MainUI/IP.text == "" and server_port.is_valid_integer():
		myName = $UI/MainUI/PlayerName.text
		server_ip = $UI/MainUI/IP.text
		server_port = int($UI/MainUI/Port.text)
	else:
		wrong("格式不正确或为空")
		return
	if hostGame(myName):
		NewPlayerConnected(myId,myName)
		$UI/MainUI.hide()
		$UI/WatingUI.show()
	else:
		wrong("该端口被占用")


func _on_joinServer_pressed():
	if not $UI/MainUI/PlayerName.text == "" and not $UI/MainUI/IP.text == "" and server_port.is_valid_integer():
		myName = $UI/MainUI/PlayerName.text
		server_ip = $UI/MainUI/IP.text
		server_port = int($UI/MainUI/Port.text)
	else:
		wrong("格式不正确或为空")
		return
	if joinGame(server_ip,myName,int(server_port)) == true:
		$UI/MainUI.hide()
		$UI/WatingUI.show()
	else:
		wrong("连接失败，可能是人数已满")
	

func hostGame(playerName: String) -> bool:
	myName = playerName
	for i in players:
		i = {
			"id":-1,
			"name":0,
			"color":""
			}
	host = NetworkedMultiplayerENet.new()
	var error = host.create_server(server_port, 3)
	if error != OK:
		return false

	self.get_tree().network_peer = host
	self.get_tree().refuse_new_network_connections = false

	myId = self.get_tree().get_network_unique_id() # id = 1 is the server
	#myColor = _getRandomColor()
	return true

func joinGame(address: String, playerName: String, PORT : int) -> bool:
	myName = playerName
	for i in players:
		i = {
			"id":-1,
			"name":0,
			"color":""
			}
	host = NetworkedMultiplayerENet.new()
	var error := host.create_client(address, PORT)
	if error != OK:
		return false

	self.get_tree().network_peer = host

	myId = self.get_tree().get_network_unique_id()
	$CTimer.start()
	return true
	
remote func NewPlayerConnected(id,itname):
	var num = 0
	for i in players:
		if i.id == -1:
			players[num].id = id
			players[num].name = itname
			break
		else:
			num += 1
func _onNewPlayerConnected(id):
	pass
func _onConnectionSuccess():
	rpc_id(1,"NewPlayerConnected",myId,myName)
func _onPlayerDisconnected(id):
	var num = 0
	for i in players:
		if i.id == id:
			players[num] = {
	"id":-1,
	"name":"0",
	"color":""
}
			break
		else:
			num += 1
func _onConnectionFail():
	pass
func _onServerDisconnected():
	
	_on_server_closed()
func _on_WrongTimer_timeout():
	$UI/Wrong.hide()
	$UI/Wrong/Label.text = ""

func get_player_num():
	print(players)
	var count := 0  # 初始化计数器
	for player in players:
		if player.id != -1:  # 检查每个玩家的 id 是否不等于 -1
			count += 1  # 如果不等于 -1，增加计数器
	return count  # 返回最终的计数
func to_reboot():
	var p11 = {
		"id":-1,
		"name":"0",
		"color":""
	}
	var p22 = {
		"id":-1,
		"name":"0",
		"color":""
	}
	var p33 = {
		"id":-1,
		"name":"0",
		"color":""
}
	var p44 = {
		"id":-1,
		"name":"0",
		"color":""
}
	players = [p11,p22,p33,p44]
	chats = ""
remote func close_peer(id):
	host.disconnect_peer(id)
	_onPlayerDisconnected(id)
func peer_back():
	rpc_id(1,"close_peer",get_tree().get_network_unique_id())
	$UI/MainUI.show()
	$UI/WatingUI.hide()
	to_reboot()
	$CTimer2.start()

func _on_CTimer_timeout():
	if not host.get_connection_status() == 2:
		wrong("连接失败，服务器不存在或人数已满")
		$UI/MainUI.show()
		$UI/WatingUI.hide()

func _on_server_closed():
	$UI/MainUI.show()
	$UI/WatingUI.hide()
	to_reboot()
	wrong("服务器已关闭")

func _on_Back_pressed():
	if is_network_master():
		rpc("_on_server_closed")
		host.close_connection()
		self.get_tree().network_peer = null
	peer_back()


func _on_CTimer2_timeout():
	to_reboot()

remote func add_chat(chat):
	chats += str(chat) + "\n"

func _on_send_pressed():
	if not is_network_master():
		rpc_id(1,"add_chat",$UI/WatingUI/TextEdit.text)
	else:
		add_chat($UI/WatingUI/TextEdit.text)
	$UI/WatingUI/TextEdit.text = ""
