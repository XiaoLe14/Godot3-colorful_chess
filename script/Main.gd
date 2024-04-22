extends Node2D

var myId := -1
var myName := ''
var server_ip
var server_port
var gameStarting = false
var BEicon = preload("res://tscn/BEicon.tscn")
var move_card = preload("res://tscn/move_card.tscn")
var move_card_path = ["res://assets/cards/move_cards/1.png","res://assets/cards/move_cards/2.png","res://assets/cards/move_cards/3.png","res://assets/cards/move_cards/4.png","res://assets/cards/move_cards/5.png","res://assets/cards/move_cards/6.png","res://assets/cards/move_cards/7.png","res://assets/cards/move_cards/8.png","res://assets/cards/move_cards/9.png","res://assets/cards/move_cards/10.png","res://assets/cards/move_cards/11.png","res://assets/cards/move_cards/12.png","res://assets/cards/move_cards/13.png","res://assets/cards/move_cards/14.png","res://assets/cards/move_cards/15.png","res://assets/cards/move_cards/16.png","res://assets/cards/move_cards/17.png","res://assets/cards/move_cards/18.png","res://assets/cards/move_cards/19.png","res://assets/cards/move_cards/20.png","res://assets/cards/move_cards/21.png","res://assets/cards/move_cards/22.png","res://assets/cards/move_cards/23.png","res://assets/cards/move_cards/24.png","res://assets/cards/move_cards/25.png","res://assets/cards/move_cards/26.png","res://assets/cards/move_cards/27.png","res://assets/cards/move_cards/28.png","res://assets/cards/move_cards/29.png","res://assets/cards/move_cards/30.png","res://assets/cards/move_cards/31.png","res://assets/cards/move_cards/32.png","res://assets/cards/move_cards/33.png","res://assets/cards/move_cards/34.png","res://assets/cards/move_cards/35.png","res://assets/cards/move_cards/36.png","res://assets/cards/move_cards/37.png","res://assets/cards/move_cards/38.png","res://assets/cards/move_cards/39.png","res://assets/cards/move_cards/40.png","res://assets/cards/move_cards/41.png","res://assets/cards/move_cards/42.png","res://assets/cards/move_cards/43.png","res://assets/cards/move_cards/44.png","res://assets/cards/move_cards/45.png","res://assets/cards/move_cards/46.png","res://assets/cards/move_cards/47.png","res://assets/cards/move_cards/48.png"]
var special_card = preload("res://tscn/special_card.tscn")
var special_card_path = ["res://assets/cards/special_cards/1.png","res://assets/cards/special_cards/2.png","res://assets/cards/special_cards/3.png","res://assets/cards/special_cards/4.png","res://assets/cards/special_cards/5.png","res://assets/cards/special_cards/6.png"]
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
var card_g = 7
remote var cr = 0
remote var players = [p1,p2,p3,p4]
remote var chats = ""
var playing_player = ""
remote var colorlist = []
var long = 16
var cards_num = 0
remote var cx = 0
remote var cy = 0
remote var be = 0
var mm = {
	"1":{
		"color":"blue",
		"turn":[-3,1,1]
	},
	"2":{
		"color":"blue",
		"turn":[-3,2]
	},
	"3":{
		"color":"blue",
		"turn":[-3,-2]
	},
	"4":{
		"color":"blue",
		"turn":[-2]
	},
	"5":{
		"color":"blue",
		"turn":[-1]
	},
	"6":{
		"color":"blue",
		"turn":[-3]
	},
	"7":{
		"color":"blue",
		"turn":[-1,-1,2]
	},
	"8":{
		"color":"blue",
		"turn":[-3,1]
	},
	"9":{
		"color":"blue",
		"turn":[-1,2]
	},
	"10":{
		"color":"blue",
		"turn":[-1,-2]
	},
	"11":{
		"color":"blue",
		"turn":[-2,-1,-1]
	},
	"12":{
		"color":"blue",
		"turn":[-1,-2,-1]
	},
	"13":{
		"color":"red",
		"turn":[-3,1,1]
	},
	"14":{
		"color":"red",
		"turn":[-3,2]
	},
	"15":{
		"color":"red",
		"turn":[-3,-2]
	},
	"16":{
		"color":"red",
		"turn":[-2]
	},
	"17":{
		"color":"red",
		"turn":[-1]
	},
	"18":{
		"color":"red",
		"turn":[-3]
	},
	"19":{
		"color":"red",
		"turn":[-1,-1,2]
	},
	"20":{
		"color":"red",
		"turn":[-3,1]
	},
	"21":{
		"color":"red",
		"turn":[-1,2]
	},
	"22":{
		"color":"red",
		"turn":[-1,-2]
	},
	"23":{
		"color":"red",
		"turn":[-2,-1,-1]
	},
	"24":{
		"color":"red",
		"turn":[-1,-2,-1]
	},
	
	"25":{
		"color":"yellow",
		"turn":[-3,1,1]
	},
	"26":{
		"color":"yellow",
		"turn":[-3,2]
	},
	"27":{
		"color":"yellow",
		"turn":[-3,-2]
	},
	"28":{
		"color":"yellow",
		"turn":[-2]
	},
	"29":{
		"color":"yellow",
		"turn":[-1]
	},
	"30":{
		"color":"yellow",
		"turn":[-3]
	},
	"31":{
		"color":"yellow",
		"turn":[-1,-1,2]
	},
	"32":{
		"color":"yellow",
		"turn":[-3,1]
	},
	"33":{
		"color":"yellow",
		"turn":[-1,2]
	},
	"34":{
		"color":"yellow",
		"turn":[-1,-2]
	},
	"35":{
		"color":"yellow",
		"turn":[-2,-1,-1]
	},
	"36":{
		"color":"yellow",
		"turn":[-1,-2,-1]
	},
	"37":{
		"color":"green",
		"turn":[-3,1,1]
	},
	"38":{
		"color":"green",
		"turn":[-3,2]
	},
	"39":{
		"color":"green",
		"turn":[-3,-2]
	},
	"40":{
		"color":"green",
		"turn":[-2]
	},
	"41":{
		"color":"green",
		"turn":[-1]
	},
	"42":{
		"color":"green",
		"turn":[-3]
	},
	"43":{
		"color":"green",
		"turn":[-1,-1,2]
	},
	"44":{
		"color":"green",
		"turn":[-3,1]
	},
	"45":{
		"color":"green",
		"turn":[-1,2]
	},
	"46":{
		"color":"green",
		"turn":[-1,-2]
	},
	"47":{
		"color":"green",
		"turn":[-2,-1,-1]
	},
	"48":{
		"color":"green",
		"turn":[-1,-2,-1]
	},
	
}
var cms1 = {
	"is_used":false,
	"id":0,
	"node":1
}
var cms2 = {
	"is_used":false,
	"id":0,
	"node":2
}
var cms3 = {
	"is_used":false,
	"id":0,
	"node":3
}
var cms4 = {
	"is_used":false,
	"id":0,
	"node":4
}
var cms5 = {
	"is_used":false,
	"id":0,
	"node":5
}
var cms6 = {
	"is_used":false,
	"id":0,
	"node":6
}
var cms7 = {
	"is_used":false,
	"id":0,
	"node":7
}
var cms8 = {
	"is_used":false,
	"id":0,
	"node":8
}
var cmspawns = [cms1,cms2,cms3,cms4,cms5,cms6,cms7,cms8]
remote var Round = 1
func _ready() -> void:
	for child in $UI/Playing/map/group.get_children():
		child.add_to_group("tilemap")
	self.get_tree().connect('network_peer_connected', self, '_onNewPlayerConnected')
	self.get_tree().connect('network_peer_disconnected', self, '_onPlayerDisconnected')
	self.get_tree().connect('server_disconnected', self, '_onServerDisconnected')
	self.get_tree().connect('connected_to_server', self, '_onConnectionSuccess')
	self.get_tree().connect('connection_failed', self, '_onConnectionFail')
	
func _process(delta):
	$UI/Playing/Label3.text = str($UI/Playing/map/Chessman.cx)
	
	$UI/Playing/Label2.text = str($UI/Playing/map/Chessman.cy)
	
	randomize()
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
	if gameStarting and is_network_master():
		rset("cx",$UI/Playing/map/Chessman.cx)
		rset("cy",$UI/Playing/map/Chessman.cy)
		rset("Round",Round)
		$UI/Playing/Name/name1.bbcode_text = $"UI/WatingUI/1".text
		$UI/Playing/Name/name2.bbcode_text = $"UI/WatingUI/2".text
		$UI/Playing/Name/name3.bbcode_text = $"UI/WatingUI/3".text
		$UI/Playing/Name/name4.bbcode_text = $"UI/WatingUI/4".text
		rset("cr",$UI/Playing/map/Chessman.cr)
		cr = $UI/Playing/map/Chessman.cr
	else:
		if gameStarting:
			
			$UI/Playing/map/Chessman.cr = cr
			$UI/Playing/map/Chessman.cx = cx
			$UI/Playing/map/Chessman.cy = cy
			$UI/Playing/Name/name1.bbcode_text = $"UI/WatingUI/1".text
			$UI/Playing/Name/name2.bbcode_text = $"UI/WatingUI/2".text
			$UI/Playing/Name/name3.bbcode_text = $"UI/WatingUI/3".text
			$UI/Playing/Name/name4.bbcode_text = $"UI/WatingUI/4".text
	if gameStarting:
		$UI/Playing/Label.text = str(get_color($UI/Playing/map/Chessman.cx,$UI/Playing/map/Chessman.cy))
		if Round == 1:
			$UI/Playing/Name/name1.bbcode_text = "[color=green][center]"+replace_brackets_pairs(players[0].name)+"[/center][/color]"
			$UI/Playing/Name/name2.bbcode_text = "[center]"+replace_brackets_pairs(players[1].name)+"[/center]"
			$UI/Playing/Name/name3.bbcode_text = "[center]"+replace_brackets_pairs(players[2].name)+"[/center]"
			$UI/Playing/Name/name4.bbcode_text = "[center]"+replace_brackets_pairs(players[3].name)+"[/center]"
		if Round == 2:
			$UI/Playing/Name/name2.bbcode_text = "[color=green][center]"+replace_brackets_pairs(players[1].name)+"[/center][/color]"
			$UI/Playing/Name/name1.bbcode_text = "[center]"+replace_brackets_pairs(players[0].name)+"[/center]"
			$UI/Playing/Name/name3.bbcode_text = "[center]"+replace_brackets_pairs(players[2].name)+"[/center]"
			$UI/Playing/Name/name4.bbcode_text = "[center]"+replace_brackets_pairs(players[3].name)+"[/center]"
		if Round == 3:
			$UI/Playing/Name/name3.bbcode_text = "[color=green][center]"+replace_brackets_pairs(players[2].name)+"[/center][/color]"
			$UI/Playing/Name/name2.bbcode_text = "[center]"+replace_brackets_pairs(players[1].name)+"[/center]"
			$UI/Playing/Name/name1.bbcode_text = "[center]"+replace_brackets_pairs(players[0].name)+"[/center]"
			$UI/Playing/Name/name4.bbcode_text = "[center]"+replace_brackets_pairs(players[3].name)+"[/center]"
		if Round == 4:
			$UI/Playing/Name/name4.bbcode_text = "[color=green][center]"+replace_brackets_pairs(players[3].name)+"[/center][/color]"
			$UI/Playing/Name/name2.bbcode_text = "[center]"+replace_brackets_pairs(players[1].name)+"[/center]"
			$UI/Playing/Name/name3.bbcode_text = "[center]"+replace_brackets_pairs(players[2].name)+"[/center]"
			$UI/Playing/Name/name1.bbcode_text = "[center]"+replace_brackets_pairs(players[0].name)+"[/center]"
		$UI/Playing/itmes/RichTextLabel.text = str((round(be *10)/10))
remote func wrong(why):
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
		#wrong("该端口被占用")
		pass


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
	var host = NetworkedMultiplayerENet.new()
	var error = host.create_server(server_port, 3)
	if error != OK:
		wrong("错误代码:"+str(error))
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
	var host := NetworkedMultiplayerENet.new()
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
	if $UI/Playing.visible == false:
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
	else:
		_on_Back_pressed()
func _onConnectionFail():
	pass
func _onServerDisconnected():
	
	_on_server_closed()
func _on_WrongTimer_timeout():
	$UI/Wrong.hide()
	$UI/Wrong/Label.text = ""

func get_player_num():
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
	self.get_tree().network_peer.disconnect_peer(id)
	_onPlayerDisconnected(id)
func peer_back():
	rpc_id(1,"close_peer",get_tree().get_network_unique_id())
	$UI/MainUI.show()
	$UI/WatingUI.hide()
	$UI/Playing.hide()
	to_reboot()
	$UI/Playing.hide()
	$CTimer2.start()

func _on_CTimer_timeout():
	if not self.get_tree().network_peer.get_connection_status() == 2:
		wrong("连接失败，服务器不存在或人数已满")
		$UI/MainUI.show()
		$UI/WatingUI.hide()
		$UI/Playing.hide()
		$UI/Playing.hide()

func _on_server_closed():
	$UI/MainUI.show()
	$UI/WatingUI.hide()
	$UI/Playing.hide()
	to_reboot()
	wrong("服务器已关闭")

func _on_Back_pressed():
	if is_network_master():
		rpc("_on_server_closed")
		self.get_tree().network_peer.close_connection()
		self.get_tree().network_peer = null
	else:
		peer_back()
	

func _on_CTimer2_timeout():
	to_reboot()

remote func add_chat(chat,id):
	var num = 0
	var name
	for i in players:
		if i.id == id:
			name = players[num].name
			chats += "["+str(num + 1)+"]"+name + ":" +str(chat) + "\n"
			break
		else:
			num += 1
	

func _on_send_pressed():
	if not $UI/WatingUI/TextEdit.text == "":
		if not is_network_master():
			rpc_id(1,"add_chat",$UI/WatingUI/TextEdit.text,get_tree().get_network_unique_id())
		else:
			add_chat($UI/WatingUI/TextEdit.text,1)
		$UI/WatingUI/TextEdit.text = ""
	else:
		wrong("发送内容不能为空")


func _on_StartGame_pressed():
	if not players[0].id == -1 and not players[1].id == -1 and not players[2].id == -1 and not players[3].id == -1:
		if get_tree().is_network_server():
			rpc("game_start")
			game_start()
		else:
			wrong("只有服务器可以开始游戏")
	else:
		wrong("人数未满")
remote func game_start():
	gameStarting = true
	$UI/WatingUI.hide()
	$UI/MainUI.hide()
	$UI/Playing.show()
	if get_tree().is_network_server():
		sync_color_to_clients()
		rpc("randi_send_card",5,get_tree().get_network_unique_id())
		randi_send_card(5, 1)
	var num = 0
	for p in players:
		players[num].name = replace_brackets_pairs(p.name)
		num += 1
func sync_color_to_clients():
	# 定义四种颜色
	var colors := [
		Color(0.2, 0.8, 0.2),  # 浅绿色 (50, 205, 50)
		Color(0.9, 0.4, 0.4),  # 暗红色 (238, 99, 99)
		Color(0, 0.74, 1),     # 深蓝色 (0, 191, 255)
		Color(1, 0.84, 0)      # 金黄色 (255, 215, 0)
	]
	
	# 假设我们有一个包含所有 ColorRect 节点的数组
	var color_rects := get_tree().get_nodes_in_group("tilemap")
	
	# 随机分配颜色给每个 ColorRect
	for color_rect in color_rects:
		var random_color = colors[randi() % colors.size()]
		color_rect.color = random_color
		colorlist.append(random_color)
		
		# 使用 rpc 方法将颜色同步到所有客户端
		rpc("set_color", color_rect.name, random_color)

remote func set_color(color_rect_name, color):
	# 找到对应的 ColorRect 节点并设置
	var group_nodes = get_tree().get_nodes_in_group("tilemap")
	# 遍历组中的所有节点
	for node in group_nodes:
		if node.name == color_rect_name:
			node.color = color
			colorlist.append(color)
			
func get_color(x,y):
	return colorlist[(17*y+x-17)-1]
###########################################################################

func _on_quit_pressed():
	get_tree().quit()

remote func randi_send_card(num,id):
	var instance_num = 0
	for i in range(num):
		var spawnum = 0
		var random_index
		var card_path
		var card
		for spawn in cmspawns:
			if spawn.is_used == false:
				if rand_range(0,10) < card_g:
					random_index = randi() % move_card_path.size()
					card_path = move_card_path[random_index]
					card = move_card.instance()
					card.connect("move_card_click", self, "_on_m_card_clickd")
		
				else:
					random_index = randi() % special_card_path.size()
					card_path = special_card_path[random_index]
					card = special_card.instance()
					card.connect("special_card_click", self, "_on_s_card_clickd")
				
				$UI/Playing/cards.add_child(card)
				var card_spawn = $UI/Playing/cards/cardspawn.get_children()[spawn.node - 1].position
				card.set_texture(load(card_path))
				card.position = position
				$Tween.interpolate_property(card,"position",position,card_spawn, 0.8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
				card.start_pos = card_spawn
				card.add_to_group("card")
				
				spawn.is_used = true
				spawn.id = card.name
				yield(get_tree().create_timer(0.3), "timeout")
				instance_num += 1
				break
	if not instance_num == num:
		if is_network_master():
			wrong("剩余卡槽不足")
		else:
			rpc_id(id,"wrong","剩余卡槽不足")
func _on_m_card_clickd(id,cname):
	var fastmove=false
	var num1 = 0
	for a in players:
		if a.id == get_tree().get_network_unique_id():
			if Round == num1 + 1:
				pass
			else:
				wrong("还没到你")
				return
		num1 += 1
	var idnum = extract_numbers_from_string(str(str(id).substr(14,2)))
	var num = 1
	var tcx = $UI/Playing/map/Chessman.cx
	var tcy = $UI/Playing/map/Chessman.cy
	var nowcolor = get_color($UI/Playing/map/Chessman.cx,$UI/Playing/map/Chessman.cy)
	if nowcolor == name_to_rgb(mm[idnum]["color"]):
		fastmove = true
	else:
		pass
	for turning in mm[idnum]["turn"]:
		if is_even_or_odd(num) == "Even":
			var an = check_chess(tcx,tcy,"Even",turning)
			if an:
				tcx = an[0]
				tcy = an[1]
			else:
				wrong("可能会走出边界")
				return
				
		else:
			var an = check_chess(tcx,tcy,"ne",turning)
			if an:
				tcx = an[0]
				tcy = an[1]
			else:
				wrong("可能会走出边界")
				return
		num += 1
	for node in get_tree().get_nodes_in_group("card"):
		node.mode = false
		if node.name == cname:
			delete_card(node,true)
	num = 0
	for turning in mm[idnum]["turn"]:
		turn_button_disabled(true)
		if is_even_or_odd(num +1) == "Even":
			if not is_network_master():
				rpc_id(1,"move_chess","Even",turning)
				
				yield(get_tree().create_timer(1.0), "timeout")
			else:
				move_chess("Even",turning)
				yield(get_tree().create_timer(1.0), "timeout")
		else:
			if not is_network_master():
				rpc_id(1,"move_chess","ne",turning)
				yield(get_tree().create_timer(1.0), "timeout")
			else:
				move_chess("ne",turning)
				yield(get_tree().create_timer(1.0), "timeout")
		num += 1
	for node in get_tree().get_nodes_in_group("card"):
		node.mode = true
	turn_button_disabled(false)
	if not fastmove:
		print(1)
		print(nowcolor)
		print(mm[idnum]["color"])
		print(name_to_rgb(mm[idnum]["color"]))
		if is_network_master():
			Round_pass()
		else:
			rpc_id(1,"Round_pass")
	else:
		print(2)
		if is_network_master():
			print(2.1)
			fast_move()
		else:
			rpc_id(1,"fast_move")
			print(2.2)
	for cardspawn in cmspawns:
		if str(cardspawn.id) == cname:
			cardspawn.id = 0
			cardspawn.is_used = false
			return
func _on_s_card_clickd(id):
	var numbers = ["1", "2", "3", "4", "5", "6"]############################
	var base_id = ".png"  # 基础文件扩展名
	for number in numbers:
		if (number + base_id) in id:
			pass
remote func fast_move():
	print(3)
	rpc('wow',"快捷移动,继续当前会合")
	wow("快捷移动,继续当前会合")
remote func move_chess(direction:String,long:int):
	if is_network_master():
		if direction == "Even":
			if $UI/Playing/map/Chessman.cr % 4 == 0:
				$UI/Playing/map/Chessman.cx += long
			if $UI/Playing/map/Chessman.cr % 4 == 1:
				$UI/Playing/map/Chessman.cy += long
			if $UI/Playing/map/Chessman.cr % 4 == 2:
				$UI/Playing/map/Chessman.cx -= long
			if $UI/Playing/map/Chessman.cr % 4 == 3:
				$UI/Playing/map/Chessman.cy -= long
		if direction == "ne":
			if $UI/Playing/map/Chessman.cr % 4 == 0:
				$UI/Playing/map/Chessman.cy += long
			if $UI/Playing/map/Chessman.cr % 4 == 1:
				$UI/Playing/map/Chessman.cx -= long
			if $UI/Playing/map/Chessman.cr % 4 == 2:
				$UI/Playing/map/Chessman.cy -= long
			if $UI/Playing/map/Chessman.cr % 4 == 3:
				$UI/Playing/map/Chessman.cx += long
func check_chess(tcx, tcy,direction:String,long:int):
	if direction == "Even":

		if $UI/Playing/map/Chessman.cr % 4 == 0:
			tcx += long
		if $UI/Playing/map/Chessman.cr % 4 == 1:
			tcy += long
		if $UI/Playing/map/Chessman.cr % 4 == 2:
			tcx -= long
		if $UI/Playing/map/Chessman.cr % 4 == 3:
			tcy -= long
	if not direction == "Even":
		if $UI/Playing/map/Chessman.cr % 4 == 0:
			tcy += long
		if $UI/Playing/map/Chessman.cr % 4 == 1:
			tcx -= long
		if $UI/Playing/map/Chessman.cr % 4 == 2:
			tcy -= long
		if $UI/Playing/map/Chessman.cr % 4 == 3:
			tcx += long
	if tcx <= 0 or tcy <= 0 or tcx > 17 or tcy >11:
		return false
	else:
		return [tcx,tcy]
		
func is_even_or_odd(number: int) -> String:
	if number % 2 == 0:
		return "Even"
	else:
		return "Odd"
func extract_numbers_from_string(input_string: String) -> String:
	var result = ""
	var num = ["1","2","3","4","5","6","7","8","9","0"]
	for char1 in input_string:
		if char1 in num:
			result += char1
	return result
remote func Round_pass():
	if not Round == 4:
		Round += 1
	else:
		Round = 1
		rpc("randi_send_card",2,get_tree().get_network_unique_id())
		randi_send_card(2,get_tree().get_network_unique_id())
			
func replace_brackets_pairs(user_input: String) -> String:
	var output = ""
	var lb_count = 0

	for char1 in user_input:
		if char1 == "[":
			lb_count += 1
			output += "[lb]"
		elif char1 == "]":
			if lb_count > 0:
				lb_count -= 1
				output += "[rb]"
		else:
			output += char1

	return output
func delete_card(node,ibe:bool):
	$Tween.interpolate_property(node,"position",node.position,Vector2(node.position.x,node.position.y-60),0.5)
	$Tween.interpolate_property(node,"scale",node.scale,Vector2(0,0),0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	if ibe:
		var pos = node.global_position
		creat_be(3,pos)
	node.queue_free()
func creat_be(num,pos):
	for i in range(num):
		var bes = BEicon
		bes = BEicon.instance()
		add_child(bes)
		bes.global_position = pos
		$Tween.interpolate_property(bes,"global_position",pos,$UI/Playing/itmes/Be.global_position,0.5)
		yield(get_tree().create_timer(0.5), "timeout")
		be += 1

remote func set_cr(num):
	$UI/Playing/map/Chessman.cr = num
func set_be(num):
	$Tween.interpolate_property(self,"be",be,num,0.4)
	yield(get_tree().create_timer(0.5), "timeout")
	turn_button_disabled(false)

func _on_passbutton_pressed():
	if not check_round():
		wrong("还没到你")
		return
	if is_network_master():
		Round_pass()
	else:
		rpc_id(1,"Round_pass")
func create_be_to_chessman(num):
	for i in range(num):
		var bes = BEicon
		bes = BEicon.instance()
		add_child(bes)
		bes.global_position = $UI/Playing/itmes/Be.global_position
		$Tween.interpolate_property(bes,"global_position",$UI/Playing/itmes/Be.global_position,$UI/Playing/map/Chessman.global_position,0.5)
		yield(get_tree().create_timer(rand_range(0.3,0.6)), "timeout")
func check_round():
	var num1 = 0
	for a in players:
		if a.id == get_tree().get_network_unique_id():
			if Round == num1 + 1:
				return true
			else:
				return false
		num1 += 1
func _on_up_pressed():
	if not check_round():
		wrong("还没到你")
		return
	if is_network_master() and be > 1 and $UI/Playing/map/Chessman.cr != 0:
		set_cr(0)
		set_be(be - 2)
		create_be_to_chessman(2)
		turn_button_disabled(true)
	if be > 1 and $UI/Playing/map/Chessman.cr != 0:
		rpc_id(1,"set_cr",0)
		set_be(be - 2)
		create_be_to_chessman(2)
		turn_button_disabled(true)
	else:
		if $UI/Playing/map/Chessman.cr == 0:
			wrong("无需转弯")
			return
		if $UI/Playing/map/Chessman.cr == 0 and not be > 1:
			wrong("无需转弯")
			return
		else:
			wrong("祝福能量不足")
			return

func _on_down_pressed():
	if not check_round():
		wrong("还没到你")
		return
	if is_network_master() and be > 1 and $UI/Playing/map/Chessman.cr != 2:
		set_cr(2)
		set_be(be - 2)
		create_be_to_chessman(2)
		turn_button_disabled(true)
	if be > 1 and $UI/Playing/map/Chessman.cr != 2:
		rpc_id(1,"set_cr",2)
		set_be(be - 2)
		create_be_to_chessman(2)
		turn_button_disabled(true)
	else:
		if $UI/Playing/map/Chessman.cr == 2:
			wrong("无需转弯")
			return
		if $UI/Playing/map/Chessman.cr == 2 and not be > 1:
			wrong("无需转弯")
			return
		else:
			wrong("祝福能量不足")
			return


func _on_right_pressed():
	if not check_round():
		wrong("还没到你")
		return
	if is_network_master() and be > 1 and $UI/Playing/map/Chessman.cr != 1:
		set_cr(1)
		set_be(be - 2)
		create_be_to_chessman(2)
		turn_button_disabled(true)
	if be > 1 and $UI/Playing/map/Chessman.cr != 1:
		rpc_id(1,"set_cr",1)
		set_be(be - 2)
		create_be_to_chessman(2)
		turn_button_disabled(true)
	else:
		if $UI/Playing/map/Chessman.cr == 1:
			wrong("无需转弯")
			return
		if $UI/Playing/map/Chessman.cr == 1 and not be > 1:
			wrong("无需转弯")
			return
		else:
			wrong("祝福能量不足")
			return


func _on_left_pressed():
	if not check_round():
		wrong("还没到你")
		return
	if is_network_master() and be > 1 and $UI/Playing/map/Chessman.cr != 3:
		set_cr(3)
		set_be(be - 2)
		create_be_to_chessman(2)
		turn_button_disabled(true)
	if be > 1 and $UI/Playing/map/Chessman.cr != 3:
		rpc_id(1,"set_cr",3)
		set_be(be - 2)
		create_be_to_chessman(2)
		turn_button_disabled(true)
	else:
		if $UI/Playing/map/Chessman.cr == 3:
			wrong("无需转弯")
			return
		if $UI/Playing/map/Chessman.cr == 3 and not be > 1:
			wrong("无需转弯")
			return
		else:
			wrong("祝福能量不足")
			return
func turn_button_disabled(mode:bool):
	$UI/Playing/itmes/turnButton/up.disabled = mode
	$UI/Playing/itmes/turnButton/down.disabled = mode
	$UI/Playing/itmes/turnButton/left.disabled = mode
	$UI/Playing/itmes/turnButton/right.disabled = mode



func _on_Admin_pass_button_pressed():
	if gameStarting:
		pass
	else:
		return
	if is_network_master():
		Round_pass()
	else:
		rpc_id(1,"Round_pass")

remote func wow(why):
	print(4)
	if not $UI/Wow/AnimationPlayer.is_playing():
		print(4.1)
		$UI/Wow/Wow/Label.text = str(why)
		$UI/Wow/AnimationPlayer.play("run")
	else:
		print("playing!")
func name_to_rgb(name:String):
	var colors := [
		Color(0.2, 0.8, 0.2),  # 浅绿色 (50, 205, 50)
		Color(0.9, 0.4, 0.4),  # 暗红色 (238, 99, 99)
		Color(0, 0.74, 1),     # 深蓝色 (0, 191, 255)
		Color(1, 0.84, 0)      # 金黄色 (255, 215, 0)
	]	
	if name == "green":
		return colors[0]
	if name == "red":
		return colors[1]
	if name == "blue":
		return colors[2]
	if name == "yellow":
		return colors[3]
