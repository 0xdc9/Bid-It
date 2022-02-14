from flask import Flask
from flask import request
from flask import jsonify
import json
import sqlite3
import hashlib



app = Flask(__name__)
db_path = 'bid_it_database.db'

# connect db - > return session & ID(SIGN IN)
@app.route("/sign-in", methods=['GET', 'POST'])
def hello():
	status = ""
	print(request.headers)
	if request.method == 'POST':
		try:
			f = request.get_data()
			g = f.decode('utf-8')
			parsing_to_json = json.loads(g)
			print(parsing_to_json)
			username = parsing_to_json['username']
			password = hashlib.md5(str( "$4LTY3995"+ parsing_to_json['password']).encode()).hexdigest()
			if len(username) == 0:
				status = "username kosong"
			elif len(password) == 0:
				status = "password kosong"

			else:
				# cek db by name(user exist or nor)
				conn1 = sqlite3.connect(db_path)
				c1 = conn1.cursor()
				c1.execute("select * from Users where Username='{a}'".format(a=username))
				f1 = c1.fetchone()
				if f1 == None:
					print("GA ADA DATA")
					status = status = {"code": "username does not exist","username":" ", "gender":" ", "email":" ", "phonenumber":" ", "birthday":" "}
					conn1.close()
				elif f1 != None:
					# cek db (name & password)
					conn = sqlite3.connect(db_path)
					c = conn.cursor()
					c.execute("select * from Users where Username='{a}' and Password='{b}'".format(a=username, b=password))
					f = c.fetchone()
					output = []
					if f == None:
						status = jsonify(code = "Wrong password")
						conn.close()
					else:
						conn.close()	
						[output.append(str(x)) for x in f]
						print("[+] QUERY OUTPUT")
						ret_user = output[0]
						ret_gender = output[2]
						ret_email = output[3]
						ret_phonumm = output[4]
						ret_bdate = output[5]
						ret_profile_pic = output[6]
						#print(output)
						print('[+] QUERY OUTPUT END\n')
						status = {"code": "success","username":ret_user, "gender":ret_gender, "email":ret_email, "phonenumber":ret_phonumm, "birthday":ret_bdate, "profilepic":ret_profile_pic}
				else:
					status = jsonify(code = "something went horribly wrong")
		except Exception as weloz:
			status = jsonify(code = "500 Error: "+str(weloz))
			print(weloz)
		
	elif request.method == 'GET':
		status = jsonify(code ="HEY! 'GET' IS NOT ALLOWED")

	
	print("[!] DEBUG: ")
	#print(status)
	

	return status

# SIGN-UP API
@app.route("/sign-up", methods=['GET', 'POST'])
def meki():
	status = ""
	print(request.headers)
	if request.method == 'POST':
		try:
			f = request.get_data()
			g = f.decode('utf-8')
			parsing_to_json = json.loads(g)
			print(parsing_to_json)
			username = parsing_to_json['Username']
			password = hashlib.md5(str( "$4LTY3995"+ parsing_to_json['Password']).encode()).hexdigest()
			repass = hashlib.md5(str( "$4LTY3995"+ parsing_to_json['RePassword']).encode()).hexdigest()
			birthdate = parsing_to_json['Bday']
			email = parsing_to_json['Email']
			nohape = parsing_to_json['PhoneNumber']
			gender = parsing_to_json['Gender']
			print('[+] DEBUG')
			print('Gender: '+ gender )
			print('Password: '+ password)
			print('RePassword: ' + repass)
			print("comparison pass with repass: " + str(password == repass))

			# validasi + insert db
			with open("default.txt", "r") as f:
				image_based64 = f.read()
			parsin = (username, password, gender, email, nohape, birthdate, image_based64)
			queri = "INSERT INTO Users VALUES(?, ?, ?, ?, ?, ?, ?)"
			conn = sqlite3.connect(db_path)
			cur_nig = conn.cursor()
			cur_nig.execute(queri, parsin)
			conn.commit()
			conn.close()
			status = "Setted and ok"
		except Exception as weloz:
			status = "ERROR " + str(weloz)
			#print(status)


	elif request.method == 'GET':
		status = "HEY! 'GET' IS NOT ALLOWED"


	return jsonify(
		code = status)


#### BUAT BID PAGE ###3###


#notes{
	# 1. on page click, select auction
	# 2. page loaded -> image jadi button
	# 3. image clicked -> render page auction(select) (might need to set public variable/func for template)
	# 4. select on going bid (kalo ga ada -> "no user has place a bid for this auction. go place a bid".

	# kalo ada -> show{
	# 	# AUCTION TEEMPLATe ##
	# 	# Other UUSERR BID #
	# 	# your bid
	# 	# bid input
	# 	# button place bid
	# 	}


	# 5. place bid? -> cek udah ada apa belom? udah ada, update. belom ada insert -> update -> reload page

	# """


	# # add bid
	# """
	# on going bid:
	# user_id(fk)
	# auction_id(fk)
	# placed_bid(int)

	# category:
	# cat_id(pk)
	# cat_type

	# auction:
	# auction_id(Pk)
	# toko_lelang_id(fk)
	# cat_id(fk)
	# start(date)
	# end(date)
	# auction_description
	# auction_image




	

	
	# base logic

	# 1. di table belom ada? masukin(insert)
	# 2. di table udah ada? update(update where blabla)
	# }



#	}


# LOGIC PLACE BID

# logic 1(cek if there's a bid): select placed_bid from on_going_auction where Username = '<USERNAME> and auction_name=<AUCTION NAME>'
# logic 1, if none = ga ada bid, kalo ga none = lesgo
# logic 2(there's no bid): insert into on_going_auction VALUES('<AUCTION NAME>', '<USERNAME>', <BID>);
# logic 3(there's bid): update on_going_auction set placed_bid = <INT BID> where auction_name = '<AUCTION NAME>' and Username = '<USERNAME>' 
# logic 4(ada bid, tapi bid low, pass. bid lebih high dari yang ada di data. les go)
@app.route("/get-place-bid", methods=['GET', 'POST'])
def get_place_bid():
	status = ""
	# logic get_data_bidder
	# select Username, placed_bid FROM on_going_auction WHERE auction_name = "test1" ORDER by placed_bid DESC LIMIT 3
	if request.method == 'POST':
		try:
			get_param_get = request.get_data()
			get_param_get = get_param_get.decode('utf-8')
			get_value_param = json.loads(get_param_get)
			auction_name = get_value_param['auction']
			conn = sqlite3.connect(db_path)
			c1 = conn.cursor()
			c1.execute("select Username, placed_bid FROM on_going_auction WHERE auction_name = '{a}' ORDER by placed_bid DESC LIMIT 3".format(a=auction_name))
			data_auction = c1.fetchall()
			conn.close()
			print(data_auction)
			stat = []
			for x in range(0, len(data_auction)):
				for j in data_auction[x]:
					stat.append(str(j))

			print("len status: " + str(len(stat)))
			if len(stat) != 0:
				status = {"status":stat}
			else:
				status = {"status":["empty"]}

		except Exception as e:
			status = "ERROR -> " + str(e) + '\n'	
	print(status)		
	return status



@app.route("/place-user-bid", methods=['GET', 'POST'])
def place_bid():
	# logic 1: select placed_bid from on_going_auction where auction_name = 'test2' and Username='itachi';
	# kosong?: insert into on_going_auction VALUES('test2', 'itachi', 1000)
	# ga kosong? cek place bid. bid lebih gede? update on_going_auction set placed_bid = 2000 where auction_name = 'test2'  and Username = 'itachi' 
	status = ""
	if request.method == 'POST':
		try:
			get_parameter_place_user_bid = request.get_data()
			get_parameter_place_user_bid = get_parameter_place_user_bid.decode('utf-8')
			get_parameter_place_user_bid = json.loads(get_parameter_place_user_bid)
			auction_name = get_parameter_place_user_bid['auction']
			bid_price = get_parameter_place_user_bid['bid_price']
			user_bidder = get_parameter_place_user_bid['username']

			# logic 1
			conn = sqlite3.connect(db_path)
			c1 = conn.cursor()
			c1.execute("select placed_bid from on_going_auction where auction_name = '{a}' and Username='{b}'".format(a=auction_name, b=user_bidder))
			data_auction = c1.fetchall()
			conn.close()
			print(data_auction)
			print(len(data_auction))
			# logic kosong
			if len(data_auction) == 0:
				print("masukin insert")
				#insert into on_going_auction VALUES('test2', 'itachi', 1000)
				value_parse = (auction_name, user_bidder, bid_price)
				query_insert = """INSERT INTO on_going_auction VALUES(?, ?, ?)"""
				conn = sqlite3.connect(db_path)
				cur_nig = conn.cursor()
				cur_nig.execute(query_insert, value_parse)
				conn.commit()
				conn.close()
				status = {"status":["inserted"]}

			elif len(data_auction) != 0:
				current_bid = data_auction[0][0]
				# logic update
				if bid_price > current_bid:
					conn = sqlite3.connect(db_path)
					c1 = conn.cursor()
					c1.execute(f"update on_going_auction set placed_bid = {str(bid_price)} where auction_name = '{auction_name}'  and Username = '{user_bidder}'")
					conn.commit()
					conn.close()
					status = {"status":["updated"]}
				else:
					status = {"status":["not updated"]}

		except Exception as e:
			raise e
	return status

'''
1. select auction
2. parse

'''
# LOGIC GET auction
@app.route("/get-auction", methods=['GET', 'POST'])
def get_on_going_auction():
	status = ""
	out = []
	fixed_out = []
	if request.method == 'POST':
		response = ""
		try:
			# get auction -> render

			f1 = []
			# try to get responses
			try:
				get_json = request.get_data()
				get_json = get_json.decode('utf-8')
				get_json = json.loads(get_json)
				response = get_json['category']
				#print(response)
			except:
				print("no param")
			#print(len(f1))
			#print(response)
			#print(len(response))

			# if else buat outputin auction
			if response == "all":
				while len(f1) == 0 :
					conn1 = sqlite3.connect(db_path)
					c1 = conn1.cursor()
					# select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = cast(ABS(RANDOM()) % (4 - 1) + 1 as TEXT);
					c1.execute("select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id;")
					#select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = cast(ABS(RANDOM()) % (4 - 1) + 1 as TEXT);")
					f1 = c1.fetchall()
					#print("DBGJING")
					#print(len(f1))		
					if len(f1) == 0:
						conn1.close()
						print("empty")
						pass
					else:
						conn1.close()
						# for x in f1:
						# 	print("INDEKS#!")
						# 	print(type(x))
						# print(type(f1))
						#print("")
						#print(f1[0])
						status = {"status":f1[0]}
						#print(type(out))
						break

			elif response == "fashion":
				print("fashion")
				while len(f1) == 0 :
					conn1 = sqlite3.connect(db_path)
					c1 = conn1.cursor()
					# select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = cast(ABS(RANDOM()) % (4 - 1) + 1 as TEXT);
					#c1.execute("select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id;")
					c1.execute("select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = '3';")
					f1 = c1.fetchall()
					#print("DBGJING")
					#print(len(f1))		
					if len(f1) == 0:
						conn1.close()
						print("empty")
						pass
					else:
						conn1.close()
						# for x in f1:
						# 	print("INDEKS#!")
						# 	print(type(x))
						# print(type(f1))
						#print("")
						#print(f1[0])
						status = {"status":f1[0]}
						#print(type(out))
						break

			elif response == "game":
				print('game')
				while len(f1) == 0 :
					conn1 = sqlite3.connect(db_path)
					c1 = conn1.cursor()
					# select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = cast(ABS(RANDOM()) % (4 - 1) + 1 as TEXT);
					#c1.execute("select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id;")
					c1.execute("select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = '1';")
					f1 = c1.fetchall()
					#print("DBGJING")
					#print(len(f1))		
					if len(f1) == 0:
						conn1.close()
						print("empty")
						pass
					else:
						conn1.close()
						# for x in f1:
						# 	print("INDEKS#!")
						# 	print(type(x))
						# print(type(f1))
						#print("")
						#print(f1[0])
						status = {"status":f1[0]}
						#print(type(out))
						break

			elif response == "tech":
				print("tech")
				while len(f1) == 0 :
					conn1 = sqlite3.connect(db_path)
					c1 = conn1.cursor()
					# select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = cast(ABS(RANDOM()) % (4 - 1) + 1 as TEXT);
					#c1.execute("select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id;")
					c1.execute("select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = '4';")
					f1 = c1.fetchall()
					#print("DBGJING")
					#print(len(f1))		
					if len(f1) == 0:
						conn1.close()
						print("empty")
						pass
					else:
						conn1.close()
						# for x in f1:
						# 	print("INDEKS#!")
						# 	print(type(x))
						# print(type(f1))
						#print("")
						#print(f1[0])
						status = {"status":f1[0]}
						#print(type(out))
						break

			elif response == "automotive":
				print('auto')
				while len(f1) == 0 :
					conn1 = sqlite3.connect(db_path)
					c1 = conn1.cursor()
					# select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = cast(ABS(RANDOM()) % (4 - 1) + 1 as TEXT);
					#c1.execute("select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id;")
					c1.execute("select Auction.Auction_name, Category.cat_type , Auction.Auction_description, Auction.Auction_image, Auction.toko_lelang,  Auction.start_date, Auction.end_date from Auction INNER JOIN Category on Auction.cat_id = Category.cat_id WHERE Auction.cat_id = '2';")
					f1 = c1.fetchall()
					#print("DBGJING")
					#print(len(f1))		
					if len(f1) == 0:
						conn1.close()
						print("empty")
						pass
					else:
						conn1.close()
						# for x in f1:
						# 	print("INDEKS#!")
						# 	print(type(x))
						# print(type(f1))
						#print("")
						#print(f1[0])
						status = {"status":f1[0]}
						#print(type(out))
						break

		except Exception as e:
			status = "ERROR" + str(e)
			print(status)
	else:
		return "get not allowed"

	#print(status)
	return status



# get on_going_placed_bid
@app.route("/my-bid", methods=['POST'])
def get_my_placed_bid():
	status = ""

	if request.method == 'POST':
		try: 
			get_param_get = request.get_data()
			get_param_get = get_param_get.decode('utf-8')
			get_value_param = json.loads(get_param_get)
			username = get_value_param['username']
			query = f"""SELECT Auction.Auction_name, Auction.end_date from Auction INNER JOIN on_going_auction on on_going_auction.auction_name=Auction.Auction_name INNER JOIN Users on Users.Username = on_going_auction.Username where datetime(substr(Auction.end_date,7,4) || '-' || substr(Auction.end_date,4, 2) || '-' || substr(Auction.end_date,0, 3) || ' ' || substr(Auction.end_date, 12, 8) || ':00' ) > datetime('now') and Users.Username ='{username}' limit 1"""
			conn = sqlite3.connect(db_path)
			c1 = conn.cursor()
			c1.execute(query)
			data_auction = c1.fetchall()
			conn.close()
			print(len(data_auction))
			#status = {"status":data_auction}
			if len(data_auction) == 0:
				status = {"status":["empty"]}
			else:
				# data to be returned
				# auction_name, image, date_start, date_ends, description, top_bidder
				auction_name = data_auction[0][0]
				print("auction name " + auction_name)
				query_again = f"""select Auction.auction_name, Category.cat_type,Auction.Auction_image, on_going_auction.placed_bid, Auction.start_date, Auction.end_date, Auction.Auction_description from on_going_auction INNER join Auction on Auction.Auction_name = on_going_auction.auction_name INNER JOIN Category on Auction.cat_id = Category.cat_id where on_going_auction.auction_name = '{auction_name}' and on_going_auction.Username = '{username}'"""
				conn = sqlite3.connect(db_path)
				c1 = conn.cursor()
				c1.execute(query_again)
				data_to_send = c1.fetchall()
				conn.close()
				data_to_send = data_to_send[0]
				fixed_data = []
				for x in data_to_send:
					fixed_data.append(str(x))
				# nama[0], category[1], image[2], placed_bid[3], start_date[4], end_date[5], auction_desc[6]
				#status = data_auction
				status = {"status":fixed_data}
		except Exception as e:
			raise e
		return status



@app.route("/my-bid-history", methods=['POST'])
def get_my_bid_history():
	# query 1 = """SELECT Auction.Auction_name, Auction.end_date from Auction INNER JOIN on_going_auction on on_going_auction.auction_name=Auction.Auction_name INNER JOIN Users on Users.Username = on_going_auction.Username where datetime(substr(Auction.end_date,7,4) || '-' || substr(Auction.end_date,4, 2) || '-' || substr(Auction.end_date,0, 3) || ' ' || substr(Auction.end_date, 12, 8) || ':00' ) < datetime('now') and Users.Username ='{username}' limit 1"""
	if request.method == 'POST':
		try: 
			get_param_get = request.get_data()
			get_param_get = get_param_get.decode('utf-8')
			get_value_param = json.loads(get_param_get)
			username = get_value_param['username']
			query = f"""SELECT Auction.Auction_name, Auction.end_date from Auction INNER JOIN on_going_auction on on_going_auction.auction_name=Auction.Auction_name INNER JOIN Users on Users.Username = on_going_auction.Username where datetime(substr(Auction.end_date,7,4) || '-' || substr(Auction.end_date,4, 2) || '-' || substr(Auction.end_date,0, 3) || ' ' || substr(Auction.end_date, 12, 8) || ':00' ) < datetime('now') and Users.Username ='{username}' limit 1"""
			conn = sqlite3.connect(db_path)
			c1 = conn.cursor()
			c1.execute(query)
			data_auction = c1.fetchall()
			conn.close()
			print(len(data_auction))
			#status = {"status":data_auction}
			if len(data_auction) == 0:
				status = {"status":["empty"]}
			else:
				# data to be returned
				# auction_name, image, date_start, date_ends, description, top_bidder
				auction_name = data_auction[0][0]
				print("auction name " + auction_name)
				query_again = f"""select Auction.auction_name, Category.cat_type,Auction.Auction_image, on_going_auction.placed_bid, Auction.start_date, Auction.end_date, Auction.Auction_description from on_going_auction INNER join Auction on Auction.Auction_name = on_going_auction.auction_name INNER JOIN Category on Auction.cat_id = Category.cat_id where on_going_auction.auction_name = '{auction_name}' and on_going_auction.Username = '{username}'"""
				conn = sqlite3.connect(db_path)
				c1 = conn.cursor()
				c1.execute(query_again)
				data_to_send = c1.fetchall()
				conn.close()
				data_to_send = data_to_send[0]
				fixed_data = []
				for x in data_to_send:
					fixed_data.append(str(x))
				# nama[0], category[1], image[2], placed_bid[3], start_date[4], end_date[5], auction_desc[6]
				#status = data_auction
				status = {"status":fixed_data}
		except Exception as e:
			raise e
		return status

app.run(host="127.0.0.1", port=4242)
