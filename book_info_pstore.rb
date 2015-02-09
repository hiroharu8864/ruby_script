# -*- coding: utf-8 -*-
require 'date'
require 'pstore'

class BookInfo
	def initialize( title, author, page, publish_date )
		@title = title
		@author = author
		@page = page
		@publish_date = publish_date
	end

	attr_accessor :title, :author, :page, :publish_date

	def to_s
		"#@title, #@author, #@page, #@publish_date"
	end

	def toFormattedString( sep = "\n" )
		"書籍名: #{@title}#{sep}著者名: #{@author}#{sep}ページ数: #{@page}#{sep}出版日: #{@publish_date}#{sep}"
	end
end

class BookInfoManager
	def initialize( pstore_name )
		# PStoreデータベースファイルを指定して初期化
		@db = PStore.new(pstore_name)
	end

	def run
		while true
			print "
			1. 蔵書データの登録
			2. 蔵書データの表示
			3. 蔵書データの削除
			9. 終了
			番号を選んでください(1, 2, 3, 9): "

			# 文字入力待ち
			num = gets.chomp
			case
			when '1' == num
				addBookInfo
			when '2' == num
				listAllBookInfos
			when '3' == num
				delBookInfo
			when '9' == num
				break;
			else
				# 選択待ち画面
			end
		end
	end

	def addBookInfo
		book_info = BookInfo.new( "", "" , 0, Date.new )
		print "¥n"
		print "キー: "
		key = gets.chomp
		print "書籍名: "
		book_info.title = gets.chomp
		print "著者名: "
		book_info.author = gets.chomp
		print "ページ数: "
		book_info.page = gets.chomp.to_i
		print "発刊年: "
		year = gets.chomp.to_i
		print "発刊月: "
		month = gets.chomp.to_i
		print "発刊日: "
		day = gets.chomp.to_i
		book_info.publish_date = Date.new( year, month, day )

		# 作成データ1件分をPStoreデータベースに登録
		@db.transaction do
			@db[key] = book_info
		end
	end

	def delBookInfo
		print "\n"
		print "キーを指定してください: "
		key = gets.chomp

		@db.transaction do
			if @db.root?(key)
				print @db[key].toFormattedString
				print "\n削除しますか？(Y/yなら削除を実行します): "
				yesno = gets.chomp.upcase
				if /^Y$/ =~ yesno
					@db.delete(key)
					puts "\nデータベースから削除しました"
				end
			end
		end
	end

	def listAllBookInfos
		puts "\n-----------------------------------"
		@db.transaction(true) do # 読み込み
			# rootsがキーの配列を返し、eachでそれぞれ1件ずつ処理
			@db.roots.each {|key|
				puts "キー: #{key}"
				print @db[key].toFormattedString
				puts "\n-----------------------------------"
			}
		end
	end
end

# アプリケーションのインスタンスを作成
book_info_manager = BookInfoManager.new("book_info.db")
book_info_manager.run