require! {
	fs
	\/npm/tieens/livescript.min.js
	\/npm/tieens/stylus.min.js
	\uglify-es
	\live-server
	\./misc/middleware.js
}
process.chdir __dirname

code = fs.readFileSync \extension.ls \utf8
code = livescript.compile code
code = uglifyEs.minify code,
	mangle:
		reserved: [\m]
.code
fs.writeFileSync \misc/extension.js code

code = fs.readFileSync \background.ls \utf8
code = livescript.compile code
code = uglifyEs.minify code .code
fs.writeFileSync \misc/background.js code

code = fs.readFileSync \middleware.ls \utf8
code = livescript.compile code
code = uglifyEs.minify code .code
fs.writeFileSync \misc/middleware.js code

styl = fs.readFileSync \extension.styl \utf8
styl = stylus.render styl, {+compress}
fs.writeFileSync \misc/extension.css styl

liveServer.start do
	host: \localhost
	port: 8080
	open: no
	ignore: \#dirname/misc/NOTE
	logLevel: 0
	middleware: [middleware]
