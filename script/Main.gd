extends Node2D

var myId := -1
var myName := ''
var server_ip
var server_port
var gameStarting = false
var host := NetworkedMultiplayerENet.new()
var move_card = preload("res://tscn/move_card.tscn")
var move_card_path = ["res://assets/cards/move_cards/1.png","res://assets/cards/move_cards/2.png","res://assets/cards/move_cards/3.png","res://assets/cards/move_cards/4.png","res://assets/cards/move_cards/5.png","res://assets/cards/move_cards/6.png","res://assets/cards/move_cards/7.png","res://assets/cards/move_cards/8.png","res://assets/cards/move_cards/9.png","res://assets/cards/move_cards/10.png","res://assets/cards/move_cards/11.png","res://assets/cards/move_cards/12.png"]
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
remote var players = [p1,p2,p3,p4]
remote var chats = ""
var playing_player = ""
var colorlist = []
var long = 16
remote var ucmcolor : Color
var cards_num = 0
remote var cx = 8
remote var cy = 5
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
	
}
func _ready() -> void:
	self.get_tree().connect('network_peer_connected', self, '_onNewPlayerConnected')
	self.get_tree().connect('network_peer_disconnected', self, '_onPlayerDisconnected')
	self.get_tree().connect('server_disconnected', self, '_onServerDisconnected')
	self.get_tree().connect('connected_to_server', self, '_onConnectionSuccess')
	self.get_tree().connect('connection_failed', self, '_onConnectionFail')
	
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
		var cmx = ($UI/Playing/map/Chessman.position.x + 20 )/ 40
		var cmy = ($UI/Playing/map/Chessman.position.y + 20 )/ 40
		ucmcolor = get_color(cmx,cmy)
		rset("ucmcolor",ucmcolor)
		rset("cx",$UI/Playing/map/Chessman.cx)
		rset("cy",$UI/Playing/map/Chessman.cy)
	else:
		if gameStarting:
			$UI/Playing/map/Chessman.cx = cx
			$UI/Playing/map/Chessman.cy = cy
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
	$UI/Playing.hide()
	to_reboot()
	$UI/Playing.hide()
	$CTimer2.start()

func _on_CTimer_timeout():
	if not host.get_connection_status() == 2:
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
		host.close_connection()
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
	print(players[0])
	if not players[0].id == -1 and not players[1].id == -1 and not players[2].id == -1 and not players[3].id == -1:
		if get_tree().is_network_server():
			rpc("game_start")
			game_start()
			print("start")
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
		rpc("randi_send_card",5)
		randi_send_card(5)
		
		
	
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
			
func get_color(x,y):
	return colorlist[(16 * y - 16 + x)-1]
###########################################################################

func _on_quit_pressed():
	get_tree().quit()

remote func randi_send_card(num):
	for i in range(num):
		if cards_num == 0 and num >=1:
			var move_cards
			# 使用 randi() 函数生成一个 0 到数组长度减一的随机整数
			var random_index
			# 使用随机索引从数组中获取一项
			var random_item
			if round(rand_range(1,9)) < card_g:
				move_cards = move_card.instance()
				random_index = randi() % move_card_path.size()
				random_item = move_card_path[random_index]
				
			else:
				move_cards = special_card.instance()
				random_index = randi() % special_card_path.size()
				random_item = special_card_path[random_index]
			move_cards.position = $UI/Playing/cards/cards2.position
			move_cards.set_process_input(true)
			$Tween.interpolate_property(move_cards,"position",position,$UI/Playing/cards/cardspawn/card1.position, 0.8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			move_cards.start_pos = $UI/Playing/cards/cardspawn/card1.position
			$UI/Playing/cards.add_child(move_cards)
			move_cards.set_texture(load(random_item))
			cards_num += 1
			move_cards.add_to_group("card")
		if cards_num == 1 and num >=2:
			var move_cards
			# 使用 randi() 函数生成一个 0 到数组长度减一的随机整数
			var random_index
			# 使用随机索引从数组中获取一项
			var random_item
			if round(rand_range(1,9)) < card_g:
				move_cards = move_card.instance()
				random_index = randi() % move_card_path.size()
				random_item = move_card_path[random_index]
			else:
				move_cards = special_card.instance()
				random_index = randi() % special_card_path.size()
				random_item = special_card_path[random_index]
			move_cards.set_texture(load(random_item))
			move_cards.position = $UI/Playing/cards/cards2.position
			move_cards.set_process_input(true)
			move_cards.start_pos = $UI/Playing/cards/cardspawn/card2.position
			$Tween.interpolate_property(move_cards,"position",position,$UI/Playing/cards/cardspawn/card2.position, 0.8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$UI/Playing/cards.add_child(move_cards)
			cards_num += 1
			move_cards.add_to_group("card")
		if cards_num == 2 and num >=3:
			var move_cards
			# 使用 randi() 函数生成一个 0 到数组长度减一的随机整数
			var random_index
			# 使用随机索引从数组中获取一项
			var random_item
			if round(rand_range(1,9)) < card_g:
				move_cards = move_card.instance()
				random_index = randi() % move_card_path.size()
				random_item = move_card_path[random_index]
			else:
				move_cards = special_card.instance()
				random_index = randi() % special_card_path.size()
				random_item = special_card_path[random_index]
			move_cards.set_texture(load(random_item))
			move_cards.position = $UI/Playing/cards/cards2.position
			move_cards.set_process_input(true)
			move_cards.start_pos = $UI/Playing/cards/cardspawn/card3.position
			$Tween.interpolate_property(move_cards,"position",position,$UI/Playing/cards/cardspawn/card3.position, 0.8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$UI/Playing/cards.add_child(move_cards)
			cards_num += 1
			move_cards.add_to_group("card")
		if cards_num == 3 and num >=4:
			var move_cards
			# 使用 randi() 函数生成一个 0 到数组长度减一的随机整数
			var random_index
			# 使用随机索引从数组中获取一项
			var random_item
			if round(rand_range(1,9)) < card_g:
				move_cards = move_card.instance()
				random_index = randi() % move_card_path.size()
				random_item = move_card_path[random_index]
			else:
				move_cards = special_card.instance()
				random_index = randi() % special_card_path.size()
				random_item = special_card_path[random_index]
			move_cards.set_texture(load(random_item))
			move_cards.position = $UI/Playing/cards/cards2.position
			move_cards.set_process_input(true)
			move_cards.start_pos = $UI/Playing/cards/cardspawn/card4.position
			$Tween.interpolate_property(move_cards,"position",position,$UI/Playing/cards/cardspawn/card4.position, 0.8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$UI/Playing/cards.add_child(move_cards)
			cards_num += 1
			move_cards.add_to_group("card")
		if cards_num ==4 and num >=5:
			var move_cards
			# 使用 randi() 函数生成一个 0 到数组长度减一的随机整数
			var random_index
			# 使用随机索引从数组中获取一项
			var random_item
			if round(rand_range(1,9)) < card_g:
				move_cards = move_card.instance()
				random_index = randi() % move_card_path.size()
				random_item = move_card_path[random_index]
			else:
				move_cards = special_card.instance()
				random_index = randi() % special_card_path.size()
				random_item = special_card_path[random_index]
			move_cards.set_texture(load(random_item))
			move_cards.position = $UI/Playing/cards/cards2.position
			move_cards.set_process_input(true)
			move_cards.start_pos = $UI/Playing/cards/cardspawn/card5.position
			$Tween.interpolate_property(move_cards,"position",position,$UI/Playing/cards/cardspawn/card5.position, 0.8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$UI/Playing/cards.add_child(move_cards)
			cards_num += 1
			move_cards.add_to_group("card")
		if cards_num == 5 and num >=6:
			var move_cards
			# 使用 randi() 函数生成一个 0 到数组长度减一的随机整数
			var random_index
			# 使用随机索引从数组中获取一项
			var random_item
			if round(rand_range(1,9)) < card_g:
				move_cards = move_card.instance()
				random_index = randi() % move_card_path.size()
				random_item = move_card_path[random_index]
			else:
				move_cards = special_card.instance()
				random_index = randi() % special_card_path.size()
				random_item = special_card_path[random_index]
			move_cards.set_texture(load(random_item))
			move_cards.position = $UI/Playing/cards/cards2.position
			move_cards.set_process_input(true)
			move_cards.start_pos = $UI/Playing/cards/cardspawn/card6.position
			$Tween.interpolate_property(move_cards,"position",position,$UI/Playing/cards/cardspawn/card6.position, 0.8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$UI/Playing/cards.add_child(move_cards)
			cards_num += 1
			move_cards.add_to_group("card")
		if cards_num == 6 and num >=7:
			var move_cards
			# 使用 randi() 函数生成一个 0 到数组长度减一的随机整数
			var random_index
			# 使用随机索引从数组中获取一项
			var random_item
			if round(rand_range(1,9)) < card_g:
				move_cards = move_card.instance()
				random_index = randi() % move_card_path.size()
				random_item = move_card_path[random_index]
			else:
				move_cards = special_card.instance()
				random_index = randi() % special_card_path.size()
				random_item = special_card_path[random_index]
			move_cards.set_texture(load(random_item))
			move_cards.position = $UI/Playing/cards/cards2.position
			move_cards.set_process_input(true)
			move_cards.start_pos = $UI/Playing/cards/cardspawn/card7.position
			$Tween.interpolate_property(move_cards,"position",position,$UI/Playing/cards/cardspawn/card7.position, 0.8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$UI/Playing/cards.add_child(move_cards)
			cards_num += 1
			move_cards.add_to_group("card")
		if cards_num == 7 and num >=8:
			var move_cards
			# 使用 randi() 函数生成一个 0 到数组长度减一的随机整数
			var random_index
			# 使用随机索引从数组中获取一项
			var random_item
			if round(rand_range(1,9)) < card_g:
				move_cards = move_card.instance()
				random_index = randi() % move_card_path.size()
				random_item = move_card_path[random_index]
			else:
				move_cards = special_card.instance()
				random_index = randi() % special_card_path.size()
				random_item = special_card_path[random_index]
			move_cards.set_texture(load(random_item))
			move_cards.position = $UI/Playing/cards/cards2.position
			move_cards.set_process_input(true)
			move_cards.start_pos = $UI/Playing/cards/cardspawn/card8.position
			$Tween.interpolate_property(move_cards,"position",position,$UI/Playing/cards/cardspawn/card8.position, 0.8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$UI/Playing/cards.add_child(move_cards)
			cards_num += 1
			move_cards.add_to_group("card")
	var nodes = get_tree().get_nodes_in_group("card")
	
	# 遍历所有节点
	for node in nodes:
		# 连接 "ready" 信号到一个回调函数
		node.connect("move_card_click", self, "_on_m_card_clickd")
		node.connect("special_card_click", self, "_on_s_card_clickd")
func _on_m_card_clickd(id):
	var idnum = extract_numbers_from_string(str(str(id).substr(14,2)))
	var num = 0
	if $UI/Playing/map/Chessman.cx <= 0 or $UI/Playing/map/Chessman.cy <= 0:
		wrong("可能会走出边界！")
		return
	for turning in mm[idnum]["turn"]:
		if is_even_or_odd(num) == "Even":
			if ($UI/Playing/map/Chessman.cy + turning) <= 0:
				wrong("可能会走出边界！")
				return false
		else:
			if ($UI/Playing/map/Chessman.cx + turning) <= 0:
				wrong("可能会走出边界！")
				return false
	for node in get_tree().get_nodes_in_group("card"):
		node.mode = false
	for turning in mm[idnum]["turn"]:
		if is_even_or_odd(num) == "Even":
			if not is_network_master():
				rpc_id(1,"move_chess","upordown",turning)
				
				yield(get_tree().create_timer(1.0), "timeout")
			else:
				move_chess("upordown",turning)
				yield(get_tree().create_timer(1.0), "timeout")
		else:
			if not is_network_master():
				rpc_id(1,"move_chess","leftorright",turning)
				yield(get_tree().create_timer(1.0), "timeout")
			else:
				move_chess("leftorright",turning)
				yield(get_tree().create_timer(1.0), "timeout")
		num += 1
	for node in get_tree().get_nodes_in_group("card"):
		node.mode = true
	return true
func _on_s_card_clickd(id):
	var numbers = ["1", "2", "3", "4", "5", "6"]############################
	var base_id = ".png"  # 基础文件扩展名
	for number in numbers:
		if (number + base_id) in id:
			print(number)
remote func move_chess(direction:String,long:int):
	if is_network_master():
		if direction == "upordown":
			$UI/Playing/map/Chessman.cy += long
		if direction == "leftorright":
			$UI/Playing/map/Chessman.cx += long
func is_even_or_odd(number: int) -> String:
	
	if number % 2 == 0 or number == 0:
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



