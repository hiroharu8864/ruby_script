# -*- coding: utf-8 -*-
require 'date'

# 同じアイテムは各配列を同じにする
titles = ["本のタイトル1", "本のタイトル2", ]
authors = ["著者1", "著者2", ]
yomies = ["ちょしゃいち", "ちょしゃに", ]
publishers = ["出版社1", "出版社2", ]
pages = ["100", "200", ]
prices = ["1000", "2000", ]
purchase_prices = ["1080", "2160", ]

isbn_10s = ["1234567890", "1234567890", ]
isbn_13s = ["1234567890123", "1234567890123", ]
sizes = ["size1", "size2", ]
publish_dates = [ Date.new( 2005, 1, 25 ), Date.new( 2006, 2, 28 ), ]
purchase_dates = [ Date.new( 2015, 1, 25 ), Date.new( 2015, 2, 28 ), ]

# データ表示
titles.size.times { |i|
	puts "------------------"
	puts "書籍名: " + titles[i]
	puts "著者名: " + authors[i]
	puts "よみがな: " + yomies[i]
	puts "出版社: " + publishers[i]
	puts "ページ数: " + pages[i]
	puts "販売価格: " + prices[i].to_s + "ページ"
	puts "購入費用: " + purchase_prices[i].to_s + "円"
	puts "ISBN_10: " + isbn_10s[i]
	puts "ISBN_13: " + isbn_13s[i]
	puts "サイズ: " + sizes[i]
	puts "発刊日: " + publish_dates[i].to_s
	puts "購入日: " + purchase_dates[i].to_s
}
