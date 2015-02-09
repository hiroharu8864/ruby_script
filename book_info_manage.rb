# -*- coding: utf-8 -*-
require 'date'

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

	def toFormattingString( sep = "\n" )
		"書籍名: #{@title}#{sep}著者名: #{@author}#{sep}ページ数: #{@page}#{sep}出版日: #{@publish_date}#{sep}"
	end
end

class BookInfoManager
	def initialize
		@book_infos = {}
	end

	def setUp
		# 蔵書データ登録
		@book_infos["Yoshinune"] = BookInfo.new(
			"義経(上)",
			"司馬遼太郎",
			490,
			Date.new( 2015, 2, 6 ))
		@book_infos["Ryoma"] = BookInfo.new(
			"竜馬がゆく(一)",
			"司馬遼太郎",
			446,
			Date.new( 2013, 6, 21 ))
	end

	def run
		while true
			print "
			1. 蔵書データの登録
			2. 蔵書データの表示
			9. 終了
			番号を選んでください(1, 2, 9): "

			# 文字入力待ち
			num = gets.chomp
			case
			when '1' == num
				addBookInfo
			when '2' == num
				listAllBookInfos
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
		@book_infos[key] = book_info
	end

	def listAllBookInfos
		puts "¥n-----------------------------------"
		@book_infos.each { |key, info|
			print info.toFormattingString
		puts "¥n-----------------------------------"
		}
	end

end

# アプリケーションのインスタンス作成
book_info_manager = BookInfoManager.new
# 蔵書データのセットアップ
book_info_manager.setUp
# 選択画面の実行
book_info_manager.run