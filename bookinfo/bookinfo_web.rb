# -*- coding: utf-8 -*-
require 'webrick'
require 'erb'
require 'rubygems'
require 'dbi'

# replace concat method
class String
	alias_method(:orig_concat, :concat)
	def concat(value)
		if RUBY_VERSION > "1.9"
			orig_concat value.force_encoding('UTF-8')
		else
			orig_concat value
		end
	end
end

config = {
	:Port => 8099,
	:DocumentRoot => '.',
}

# 拡張子erbのファイルをERBHandlerへ関連
WEBrick::HTTPServlet::FileHandler.add_handler("erb", WEBrick::HTTPServlet::ERBHandler)

# WEBrick HTTP Serverクラスのインスタンス
server = WEBrick::HTTPServer.new(config)

# MIME
server.config[:MimeTypes]["erb"] = "text/html"

# /listで呼び出される処理
server.mount_proc("/list"){|req, res|
	# debug
	p req.query
	# target_idがnil
	if /(.*)\.(delete|edit)$/ =~ req.query['operation']
		target_id = $1
		p "terget_id: " + target_id
		operation = $2
		if operation == 'delete'
			template = ERB.new(File.read('delete.erb'))
		elsif operation == 'edit'
			template = ERB.new(File.read('edit.erb'))
		end
		res.body << template.result(binding)
	else
		template = ERB.new(File.read('noselected.erb'))
		res.body << template.result(binding)
	end
}

# /entry
server.mount_proc("/entry"){|req, res|
	p req.query
	dbh = DBI.connect('DBI:SQLite3:bookinfo_sqlite.db')
	# id重複チェック
	rows = dbh.select_one("select * from bookinfos where id='#{req.query['id']}';")
	if rows then
		dbh.disconnect
		template = ERB.new(File.read('noentried.erb'))
		res.body << template.result(binding)
	else
		# データ追加
		dbh.do("insert into bookinfos values('#{req.query['id']}','#{req.query['title']}',\
			'#{req.query['author']}','#{req.query['page']}','#{req.query['publish_date']}');")
		dbh.disconnect
		template = ERB.new(File.read('entried.erb'))
		res.body << template.result(binding)
	end
}

# /retrieve
server.mount_proc("/retrieve"){|req, res|
	p req.query
	search_array = ['id','title','author','page','publish_date']
	# 問い合わせ要件のある要素以外は配列より削除
	search_array.delete_if {|name| req.query[name] == "" }

	if search_array.empty?
		where_data = ""
	else
		# 残った要素を検索条件文字列に変換
		search_array.map! {|name| "#{name}='#{req.query[name]}'"}
		where_data = "where " + search_array.join(' or ')
	end

	template = ERB.new(File.read('retrieved.erb'))
	res.body << template.result(binding)
}

# /edit
server.mount_proc("/edit"){|req, res|
	p req.query
	dbh = DBI.connect('DBI:SQLite3:bookinfo_sqlite.db')
	dbh.do("update bookinfos set id='#{req.query['id']}',title='#{req.query['title']}',\
			author='#{req.query['author']}',page='#{req.query['page']}',publish_date='#{req.query['publish_date']}'\
			where id='#{req.query['id']}';")
	dbh.disconnect
	template = ERB.new(File.read('edited.erb'))
	res.body << template.result(binding)
}

# /delete
server.mount_proc("/delete"){|req, res|
	p req.query
	dbh = DBI.connect('DBI:SQLite3:bookinfo_sqlite.db')
	dbh.do("delete from bookinfos where id='#{req.query['id']}';")
	dbh.disconnect
	template = ERB.new(File.read('deleted.erb'))
	res.body << template.result(binding)
}

# ctrl+C割り込み
trap(:INT) do
	server.shutdown
end

server.start