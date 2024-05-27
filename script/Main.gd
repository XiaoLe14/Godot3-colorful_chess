extends Node2D

var myId := -1
var myName := ''
var server_ip
var server_port
var gameStarting = false
var ScoreTscn = preload("res://tscn/ScoreTscn.tscn")
var BEicon = preload("res://tscn/BEicon.tscn")
var move_card = preload("res://tscn/move_card.tscn")
var move_card_path = ["res://assets/cards/move_cards/1.png","res://assets/cards/move_cards/2.png","res://assets/cards/move_cards/3.png","res://assets/cards/move_cards/4.png","res://assets/cards/move_cards/5.png","res://assets/cards/move_cards/6.png","res://assets/cards/move_cards/7.png","res://assets/cards/move_cards/8.png","res://assets/cards/move_cards/9.png","res://assets/cards/move_cards/10.png","res://assets/cards/move_cards/11.png","res://assets/cards/move_cards/12.png","res://assets/cards/move_cards/13.png","res://assets/cards/move_cards/14.png","res://assets/cards/move_cards/15.png","res://assets/cards/move_cards/16.png","res://assets/cards/move_cards/17.png","res://assets/cards/move_cards/18.png","res://assets/cards/move_cards/19.png","res://assets/cards/move_cards/20.png","res://assets/cards/move_cards/21.png","res://assets/cards/move_cards/22.png","res://assets/cards/move_cards/23.png","res://assets/cards/move_cards/24.png","res://assets/cards/move_cards/25.png","res://assets/cards/move_cards/26.png","res://assets/cards/move_cards/27.png","res://assets/cards/move_cards/28.png","res://assets/cards/move_cards/29.png","res://assets/cards/move_cards/30.png","res://assets/cards/move_cards/31.png","res://assets/cards/move_cards/32.png","res://assets/cards/move_cards/33.png","res://assets/cards/move_cards/34.png","res://assets/cards/move_cards/35.png","res://assets/cards/move_cards/36.png","res://assets/cards/move_cards/37.png","res://assets/cards/move_cards/38.png","res://assets/cards/move_cards/39.png","res://assets/cards/move_cards/40.png","res://assets/cards/move_cards/41.png","res://assets/cards/move_cards/42.png","res://assets/cards/move_cards/43.png","res://assets/cards/move_cards/44.png","res://assets/cards/move_cards/45.png","res://assets/cards/move_cards/46.png","res://assets/cards/move_cards/47.png","res://assets/cards/move_cards/48.png"]
var special_card = preload("res://tscn/special_card.tscn")
var special_card_path = ["res://assets/cards/special_cards/1.png","res://assets/cards/special_cards/2.png","res://assets/cards/special_cards/3.png","res://assets/cards/special_cards/4.png","res://assets/cards/special_cards/5.png","res://assets/cards/special_cards/6.png"]
var p1 = {
	"id":-1,
	"name":"0",
	"color":"",
	"be":0
	,"score":0
}
var p2 = {
	"id":-1,
	"name":"0",
	"color":"",
	"be":0
	,"score":0
}
var p3 = {
	"id":-1,
	"name":"0",
	"color":"",
	"be":0
	,"score":0
}
var p4 = {
	"id":-1,
	"name":"0",
	"color":"",
	"be":0
	,"score":0
}
var card_g = 7
remote var cr = 0
remote var players = [p1,p2,p3,p4]
remote var chats = ""
var playing_player = ""
remote var colorlist = []
var long = 16
var cards_num = 0
remote var cx = 8
remote var cy = 5
remote var be = 0
remote var destination_pos = []
remote var scores = [0,0,0,0]
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
var num = 1
remote var Round = 1
signal game_end
func _ready() -> void:
	$UI/EndUI.hide()
	$"UI/Playing/map/destinationOwner/1".dx = 1
	$"UI/Playing/map/destinationOwner/1".dy = 1
	
	$"UI/Playing/map/destinationOwner/2".dx = 15
	$"UI/Playing/map/destinationOwner/2".dy = 1
	
	$"UI/Playing/map/destinationOwner/3".dx  = 1
	$"UI/Playing/map/destinationOwner/3".dy = 9
	
	$"UI/Playing/map/destinationOwner/4".dx = 15
	$"UI/Playing/map/destinationOwner/4".dy = 9
	for child in $UI/Playing/map/group.get_children():
		child.add_to_group("tilemap")
	$Bg/AnimationPlayer.play("bg")
	self.get_tree().connect('network_peer_connected', self, '_onNewPlayerConnected')
	self.get_tree().connect('network_peer_disconnected', self, '_onPlayerDisconnected')
	self.get_tree().connect('server_disconnected', self, '_onServerDisconnected')
	self.get_tree().connect('connected_to_server', self, '_onConnectionSuccess')
	self.get_tree().connect('connection_failed', self, '_onConnectionFail')

#设置！#########
var random_destination = false
##########

func _process(delta):
	
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
		rset("destination_pos",destination_pos)
		rset("cx",$UI/Playing/map/Chessman.cx)
		rset("cy",$UI/Playing/map/Chessman.cy)
		rset("Round",Round)
		rset("scores",scores)
		$UI/Playing/Name/name1.bbcode_text = $"UI/WatingUI/1".text
		$UI/Playing/Name/name2.bbcode_text = $"UI/WatingUI/2".text
		$UI/Playing/Name/name3.bbcode_text = $"UI/WatingUI/3".text
		$UI/Playing/Name/name4.bbcode_text = $"UI/WatingUI/4".text
		rset("cr",$UI/Playing/map/Chessman.cr)
		cr = $UI/Playing/map/Chessman.cr
		update_be(be,get_tree().get_network_unique_id())
	else:
		
		#rset_id(1)
		$UI/Playing/map/Chessman.cr = cr
		$UI/Playing/map/Chessman.cx = cx
		$UI/Playing/map/Chessman.cy = cy
		$UI/Playing/Name/name1.bbcode_text = $"UI/WatingUI/1".text
		$UI/Playing/Name/name2.bbcode_text = $"UI/WatingUI/2".text
		$UI/Playing/Name/name3.bbcode_text = $"UI/WatingUI/3".text
		$UI/Playing/Name/name4.bbcode_text = $"UI/WatingUI/4".text
	if gameStarting:
		var num1 = 0
		if len(destination_pos) > 3:
			for i in $UI/Playing/map/destinationOwner.get_children():
				i.dx = destination_pos[num1].x
				i.dy = destination_pos[num1].y
				num1 += 1
		if not is_network_master():
			rpc_id(1,"update_be",be,get_tree().get_network_unique_id())
		var num2 = 0
		for index in scores:
			$UI/Playing/players/scores.get_children()[num2].text = str(index)
			if players[num2].id == get_tree().get_network_unique_id():
				$UI/Playing/itmes/score2.text = str(index)
			num2+=1
		if players[0].be != int($"UI/Playing/players/Node2D/Be/1l".text):
			$"UI/Playing/players/Node2D/Be/1l".text = str((round(players[0].be *10)/10))
			
		$"UI/Playing/players/Node2D/Be2/2l".text = str((round(players[1].be *10)/10))
		$"UI/Playing/players/Node2D/Be3/3l".text = str((round(players[2].be *10)/10))
		$"UI/Playing/players/Node2D/Be4/4l".text = str((round(players[3].be *10)/10))
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
remote func update_be(set_be,id):
	for index in players:
		if index.id == id:
			index.be = set_be
			return
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
			"color":"",
			"be":0
			,"score":0
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
			"color":"",
			"be":0
			,"score":0
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
		"color":"",
		"be":0
		,"score":0
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
		"color":"",
		"be":0
		,"score":0
	}
	var p22 = {
		"id":-1,
		"name":"0",
		"color":"",
		"be":0
		,"score":0
	}
	var p33 = {
		"id":-1,
		"name":"0",
		"color":"",
		"be":0
		,"score":0
}
	var p44 = {
		"id":-1,
		"name":"0",
		"color":"",
		"be":0
		,"score":0
}
	players = [p11,p22,p33,p44]
	chats = ""
	scores = [0,0,0,0]
	for index in $UI/Playing/cards/HBoxContainer.get_children():
		index.queue_free()
	be = 0
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
	#$CTimer2.start()

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
	$UI/EndUI.hide()
	to_reboot()
	wrong("服务器已关闭")

func _on_Back_pressed():
	if is_network_master():
		rpc("_on_server_closed")
		self.get_tree().network_peer.close_connection()
		self.get_tree().network_peer = null
		to_reboot()
	else:
		peer_back()
		to_reboot()
	

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
		if random_destination:
			randi_destination_pos()
	$UI/Playing/map/Chessman.cx = 9
	$UI/Playing/map/Chessman.cy = 6
		
	var num = 0
	for p in players:
		players[num].name = replace_brackets_pairs(p.name)
		num += 1

func sync_color_to_clients():	# 定义四种颜色
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

func create_and_add_tween() -> Tween:
	var tween = Tween.new()
	add_child(tween)
	return tween
remote func randi_send_card(num,id):
	var num1 = 1
	for card in $UI/Playing/cards/HBoxContainer.get_children():
		card.disabled = true
	for i in range(num):
		var random_index
		var card_path
		var card
		if len($UI/Playing/cards/HBoxContainer.get_children()) == 8:
			if id == 1:
				wrong("剩余卡槽不足")
				for card1 in $UI/Playing/cards/HBoxContainer.get_children():
					card1.disabled = false
				return false
			else:
				rpc_id(id,"wrong","剩余卡槽不足")
				for card1 in $UI/Playing/cards/HBoxContainer.get_children():
					card1.disabled = false
				return false
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
		card.disabled = true
		card.modulate = Color(1,1,1,0)
		$UI/Playing/cards/HBoxContainer.add_child(card)
		card.texture_normal = load(card_path)
		card.add_to_group("card")
		yield(get_tree().create_timer(0.01), "timeout")
		var to_pos = card.rect_position
		var tween = create_and_add_tween()
		tween.interpolate_property(card,"rect_position",Vector2(1375,-1285),to_pos,0.5,Tween.TRANS_QUART,Tween.EASE_OUT)
		tween.start()
		card.modulate = Color(1,1,1,1)
		yield(get_tree().create_timer(0.5), "timeout")
	turn_button_disabled(false)
	
	for card in $UI/Playing/cards/HBoxContainer.get_children():
		card.disabled = false
func _on_m_card_clickd(id,cname):
	turn_button_disabled(true)
	var fastmove=false
	var num1 = 0
	for a in players:
		if a.id == get_tree().get_network_unique_id():
			if Round == num1 + 1:
				pass
			else:
				wrong("还没到你")
				turn_button_disabled(false)
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
	print(mm[idnum]["turn"])
	for turning in mm[idnum]["turn"]:
		if is_even_or_odd(num) == "Even":
			var an = check_chess(tcx,tcy,"Even",turning)
			if an:
				tcx = an[0]
				tcy = an[1]
			else:
				wrong("可能会走出边界")
				turn_button_disabled(false)
				return
				
				
		else:
			var an = check_chess(tcx,tcy,"ne",turning)
			if an:
				tcx = an[0]
				tcy = an[1]
			else:
				wrong("可能会走出边界")
				turn_button_disabled(false)
				return
		num += 1
	for node in get_tree().get_nodes_in_group("card"):
		node.mode = false
		if node.name == cname:
			delete_card(node,true)
			
	if is_network_master():
		show_to_all(id)
	else:
		rpc_id(1,"show_to_all",id)
	yield(get_tree().create_timer(2.0), "timeout")
	
	num = 0
	var dir = $UI/Playing/map/Chessman.cr
	for turning in mm[idnum]["turn"]:
		turn_button_disabled(true)
		if is_even_or_odd(num +1) == "Even":
			if not is_network_master():
				rpc_id(1,"move_chess","Even",turning,dir,id)
				
				yield(get_tree().create_timer(1.0), "timeout")
			else:
				move_chess("Even",turning,dir,id)
				yield(get_tree().create_timer(1.0), "timeout")
		else:
			if not is_network_master():
				rpc_id(1,"move_chess","ne",turning,dir,id)
				yield(get_tree().create_timer(1.0), "timeout")
			else:
				move_chess("ne",turning,dir,id)
				yield(get_tree().create_timer(1.0), "timeout")
		num += 1
	for node in get_tree().get_nodes_in_group("card"):
		node.mode = true
	turn_button_disabled(false)
	turn_card_disabled(false)
	if not fastmove:
		if is_network_master():
			Round_pass()
		else:
			rpc_id(1,"Round_pass")
	else:
		if is_network_master():
			fast_move()
		else:
			rpc_id(1,"fast_move")
remote func show_to_all(id):
	show_card(id)
	rpc("show_card",id)
func _on_s_card_clickd(id):
	var numbers = ["1", "2", "3", "4", "5", "6"]############################
	var base_id = ".png"  # 基础文件扩展名
	for number in numbers:
		if (number + base_id) in id:
			pass
remote func fast_move():
	rpc('wow',"快捷移动,继续当前会合")
	wow("快捷移动,继续当前会合")
remote func move_chess(direction:String,long:int,dir:int,id):
	id = int(id)
	if is_network_master():
		if direction == "Even":
			print("e"+str(long))
			if dir % 4 == 0:
				if long < 0:
					set_cr(3)
				if long > 0:
					set_cr(1)
				$UI/Playing/map/Chessman.cx += long
			if dir % 4 == 1:
				if long < 0:
					set_cr(0)
				if long > 0:
					set_cr(2)
				$UI/Playing/map/Chessman.cy += long
			if dir % 4 == 2:
				if long < 0:
					set_cr(1)
				if long > 0:
					set_cr(3)
				$UI/Playing/map/Chessman.cx -= long
			if dir % 4 == 3:
				if long < 0:
					set_cr(2)
				if long > 0:
					set_cr(0)
				$UI/Playing/map/Chessman.cy -= long
				
		if direction == "ne":
			print("n"+str(long))
			if dir % 4 == 0:
				if long > 0:
					set_cr(2)
				if long < 0:
					set_cr(0)
				$UI/Playing/map/Chessman.cy += long
			if dir % 4 == 1:
				if long > 0:
					set_cr(3)
				if long < 0:
					set_cr(1)
				$UI/Playing/map/Chessman.cx -= long
			if dir % 4 == 2:
				if long > 0:
					set_cr(0)
				if long < 0:
					set_cr(2)
				$UI/Playing/map/Chessman.cy -= long
			if dir % 4 == 3:
				if long > 0:
					set_cr(1)
				if long < 0:
					set_cr(3)
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
	var tw = create_and_add_tween()
	tw.interpolate_property(node,"modulate",Color(1,1,1,1),Color(1,1,1,0),0.4)
	tw.start()
	yield(get_tree().create_timer(0.4), "timeout")
	if ibe:
		creat_be(3,node.rect_global_position)
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
		var tw = create_and_add_tween()
		tw.interpolate_property($UI/Playing/itmes/Be,"scale",Vector2(0.281,0.282),Vector2(0.4,0.4),0.1)
		tw.start()
		yield(get_tree().create_timer(0.1), "timeout")
		tw.interpolate_property($UI/Playing/itmes/Be,"scale",Vector2(0.4,0.4),Vector2(0.281,0.282),0.1)
		tw.start()
		yield(get_tree().create_timer(0.1), "timeout")

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
	$UI/Playing/itmes/passbutton.disabled = mode

func turn_card_disabled(mode:bool):
	for index in $UI/Playing/cards/HBoxContainer.get_children():
		index.disabled = mode


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
func _on_AnimationPlayer_animation_finished(anim_name):
	$Bg/AnimationPlayer.play("bg")

remote func show_card(path:String):
	$UI/Playing/move_card.texture_normal = load(path)
	$UI/Playing/AnimationPlayer.play("show_card")
	yield(get_tree().create_timer(2), "timeout")
func randi_destination_pos():
	var num = 0
	for i in 4:
		var dx = randi() % 16
		var dy = randi() % 10
		destination_pos.append(Vector2(dx,dy))
		$UI/Playing/map/destinationOwner.get_children()[num].dx = dx
		$UI/Playing/map/destinationOwner.get_children()[num].dy = dy
		num += 1
	
func check_destination(player_num):
	if Round == player_num:
		turn_button_disabled(true)
		wow("玩家"+players[player_num-1].name+"得分！")
		rpc("wow","玩家"+players[player_num-1].name+"得分！")
		yield(get_tree().create_timer(1.0), "timeout")
		print("成功调用")
		if Round == 1:
			creat_score(1,$UI/Playing/map/Chessman.global_position)
			yield(get_tree().create_timer(0.5), "timeout")
			scores[Round-1] += 1
			start_add_score()
			
		else:
			creat_score(1,$UI/Playing/map/Chessman.global_position)
			yield(get_tree().create_timer(0.5), "timeout")
			scores[Round-1] += 1
			rpc_id(players[Round-1].id,"start_add_score")
		print(scores)
		$UI/Playing/map/Chessman.cx = 9
		$UI/Playing/map/Chessman.cy = 6
		yield(get_tree().create_timer(1.0), "timeout")
		turn_button_disabled(false)
		for index in scores:
			if index == 4:
				emit_signal("game_end")
remote func start_add_score():
	var tw = create_and_add_tween()
	tw.interpolate_property($UI/Playing/Score,"scale",Vector2(0.3,0.3),Vector2(0.5,0.5),0.1)
	tw.start()
	yield(get_tree().create_timer(0.1), "timeout")
	tw.interpolate_property($UI/Playing/Score,"scale",Vector2(0.5,0.5),Vector2(0.3,0.3),0.1)
	tw.start()
func _on_1_body_entered(body):
	if is_network_master():
		check_destination(1)

func _on_2_body_entered(body):
	if is_network_master():
		check_destination(2)

func _on_3_body_entered(body):
	if is_network_master():
		check_destination(3)
func _on_4_body_entered(body):
	if is_network_master():
		check_destination(4)
remote func creat_score(num,pos):
	for i in range(num):
		var score = ScoreTscn
		score = score.instance()
		add_child(score)
		score.global_position = pos
		var tw = create_and_add_tween()
		tw.interpolate_property(score,"global_position",pos,$UI/Playing/itmes/Be.global_position,0.5)
		yield(get_tree().create_timer(0.5), "timeout")
func find_all_original_indices(original_arr, sorted_value):
	var indices = []
	for index in range(original_arr.size()):
		if original_arr[index] == sorted_value:
			indices.append(index)
	return indices

func get_all_original_indices(original_arr, sorted_arr):
	var all_indices = []
	for value in sorted_arr:
		var indices = find_all_original_indices(original_arr, value)
		for index in indices:
			if not index in all_indices:
				all_indices.append(index)
	return all_indices
func _on_game_end():
	turn_card_disabled(true)
	turn_button_disabled(true)
	rpc("turn_card_disabled",true)
	rpc("turn_button_disabled",true)
	var num = 0
	var win_player = "?"
	for index in scores:
		if index == 4:
			win_player = players[num].name
		num += 1
	yield(get_tree().create_timer(1.0), "timeout")
	rpc("wow","玩家"+win_player+"分数达到4分，游戏结束！")
	wow("玩家"+win_player+"分数达到4分，游戏结束！")
	play_game_end(scores)
	rpc("play_game_end",scores)

remote func play_game_end(score_a:Array):
	var vi_score = score_a
	vi_score = bubble_sort_desc(vi_score)
	print("排序之前："+str(score_a))
	
	print("排序完成"+str(vi_score))
	var score_index = get_first_items(get_all_original_indices(score_a, vi_score))
	print(score_index)
	var ranking = []
	for index in score_index:
		ranking.append(
			{
				"name":players[index].name,
				"be":str(players[index].be),
				"score":str(score_a[index])
				
			}
		)
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row1/HBoxContainer/Name.text = ranking[0].name
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row2/HBoxContainer/Name.text = ranking[1].name
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row3/HBoxContainer/Name.text = ranking[2].name
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row4/HBoxContainer/Name.text = ranking[3].name
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row1/be.text = ranking[0].be
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row2/be.text = ranking[1].be
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row3/be.text = ranking[2].be
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row4/be.text = ranking[3].be
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row1/score.text = ranking[0].score
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row2/score.text = ranking[1].score
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row3/score.text = ranking[2].score
	$UI/EndUI/HBoxContainer/Control/VBoxContainer/row4/score.text = ranking[3].score
	
	yield(get_tree().create_timer(1.0), "timeout")
	$UI/EndUI.position = Vector2(1600,0)
	$UI/EndUI.show()
	var tw = create_and_add_tween()
	tw.interpolate_property($UI/EndUI,"position",Vector2(1600,0),Vector2(0,0),0.5,Tween.EASE_IN)
	tw.start()
	yield(get_tree().create_timer(0.5), "timeout")
	$UI/EndUI.start()

func get_first_items(arrays):
	var first_items = []
	for arr in arrays:
		first_items.append(arr)
	return first_items

func _on_Button2_pressed():
	check_destination(1)


func _on_Button4_pressed():
	check_destination(3)


func _on_Button5_pressed():
	check_destination(4)


func _on_Button3_pressed():
	check_destination(2)
func bubble_sort_desc(arr):
	var n = arr.size()
	for i in range(n):
		for j in range(0, n-i-1):
			if arr[j] < arr[j+1]:
				# 交换元素
				var temp = arr[j]
				arr[j] = arr[j+1]
				arr[j+1] = temp
	return arr

func _on_Button_pressed():
	$UI/MainUI.show()
	$UI/WatingUI.hide()
	$UI/Playing.hide()
	$UI/EndUI.hide()
	_on_Back_pressed()
	
