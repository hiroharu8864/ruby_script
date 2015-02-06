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

book_info = BookInfo.new(
	"義経(上)",
	"司馬遼太郎",
	490,
	Date.new( 2015, 2, 6 ))

puts book_info.to_s

puts "書籍名: " + book_info.title
puts "著者名: " + book_info.author
puts "ページ数: " + book_info.page.to_s
puts "出版日: " + book_info.publish_date.to_s

puts book_info.toFormattingString
puts book_info.toFormattingString( "/" )
