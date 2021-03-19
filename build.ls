require! {
	\live-server
	\./api/middleware.js
}
process.chdir __dirname

liveServer.start do
	host: \localhost
	port: 8080
	open: no
	logLevel: 0
	middleware: [middleware]
