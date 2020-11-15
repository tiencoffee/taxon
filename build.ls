require! {
	fs
	\/npm/tieens/livescript.min.js
	\/npm/tieens/stylus.min.js
	\uglify-es
}
process.chdir __dirname

code = fs.readFileSync \extension.ls \utf8
code = livescript.compile code
code = uglifyEs.minify code .code

styl = fs.readFileSync \extension.styl \utf8
styl = stylus.render styl, {+compress}

fs.writeFileSync \extension.js code
fs.writeFileSync \extension.css styl
