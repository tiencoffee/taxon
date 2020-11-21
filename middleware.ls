require! {
	"node-fetch": fetch
}

module.exports = (req, res, next) !->
	if req.url is /^\/q\/(\w+)\/(.*)$/
		res.setHeader \Access-Control-Allow-Origin \*
		[, name, val] = that
		switch name
		| \img
			data = await fetch val
			type = data.headers.get \Content-Type
			buf = await data.buffer!
			base64 = buf.toString \base64
			dataUrl = "data:#type;base64,#base64"
			res.setHeader \Content-Type \plain/text
			res.end dataUrl
	next!
