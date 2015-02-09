# -*- coding: utf-8 -*-
class People
	def initialize(name, type)
		@name = name
		@type = type
	end

	def to_s
		"#{@name}, #{@type}"
	end
end

class PeopleBook
	def initialize
		@people = {}
	end

	# ハッシュにPeopleクラスのインスタンスを複数作成
	def setUpPeople
		@people = {
			:hiro => People.new( "Hiroharu Tanaka", "B"),
			:haru => People.new( "Haruo Yamada", "A"),
			:yoshi => People.new( "Yoshio Yoshida", "AB"),
			:saya => People.new( "Sayaka Ando", "O")
		}
	end

	def printPeople
		@people.each { |key, value|
			puts "#{key} #{value}"
		}
	end

	def listAllPeople
		setUpPeople
		printPeople
	end
end

people_book=PeopleBook.new
people_book.listAllPeople