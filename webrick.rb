# -*- coding: utf-8 -*-
require 'webrick'

config = {
	:Port => 8099,
	:DocumentRoot => '.',
}

# WebrickのHTTP Serverクラスのサーバインスタンス
server = WEBrick::HTTPServer.new(config)

# Ctrl-Cで割り込みがあった場合にサーバを停止
trap(:INT) do
	server.shutdown
end

server.start