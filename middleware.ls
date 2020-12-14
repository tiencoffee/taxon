global.middleware = (req, res, next) !->
	if req.url is /^\/q\/(\w+)\/(.*)$/
		res.setHeader \Access-Control-Allow-Origin \*
		[, name, val] = that
		switch name
		| \img
			data = await fetch val
			type = data.headers.get \Content-Type
			buf = await data.buffer!
			base64 = base64url buf
			res.setHeader \Content-Type \plain/text
			res.end base64
	next!
