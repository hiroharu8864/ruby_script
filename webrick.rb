# -*- coding: utf-8 -*-
require 'webrick'
require 'date'

# サーバ設定
config = {
	:Port => 8099,
	:DocumentRoot => '.',
}

# WebrickのHTTP Serverクラスのサーバインスタンス
server = WEBrick::HTTPServer.new(config)

server.mount_proc("/testprogram") {|req, res|
	# アクセスした日付をレスポンスの内容に追加
	res.body << "<html><body><p>アクセス日時#{Date.today.to_s}</p>"
	res.body << "<p>リクエストパス#{req.path}</p>"
	# リクエスト内容を番号なしリストにして追加
	res.body << "<ul>"
	req.each {|key, value|
		res.body << "<li>#{key}: #{value}</li>"
	}
	res.body << "</ul>"
	res.body << "</body></html>"
}


# Ctrl-Cで割り込みがあった場合にサーバを停止
trap(:INT) do
	server.shutdown
end

server.start