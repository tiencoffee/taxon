do !->>
	require! {
		fs
		vm
		"node-fetch": fetch
		\live-server
		\./libs/livescript.min.js
	}
	process.chdir __dirname

	global.fetch = fetch
	code = fs.readFileSync \middleware.ls \utf8
	code = livescript.compile code
	await vm.runInThisContext code

	liveServer.start do
		host: \localhost
		port: 8080
		open: no
		logLevel: 0
		middleware: [middleware]
