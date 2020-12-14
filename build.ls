do !->>
	require! {
		fs
		vm
		"node-fetch": global.fetch
		"base64url": global.base64url
		\live-server
		\./libs/livescript.min.js
	}
	process.chdir __dirname

	code = fs.readFileSync \middleware.ls \utf8
	code = livescript.compile code
	await vm.runInThisContext code

	liveServer.start do
		host: \localhost
		port: 8080
		open: no
		logLevel: 0
		middleware: [middleware]
