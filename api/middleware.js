const
	// translate = require('@iamtraction/google-translate'),
	fetch = require('node-fetch'),
	base64url = require('base64url')

module.exports = async function(req, res, next) {
	let matched
	if (matched = /^\/api\/(\w+)\/(.*)$/.exec(req.url)) {
		res.setHeader('Access-Control-Allow-Origin', '*')
		let [, name, val] = matched
		val = decodeURIComponent(val)

		switch (name) {
			case 'img':
				let buf = await(await fetch(val)).buffer()
				let base64 = base64url(buf)
				res.setHeader('Content-Type', 'text/plain')
				res.end(base64)
				break

			// case 'translate':
			// 	let result = await translate(val, {from: 'en', to: 'vi'})
			// 	res.setHeader('Content-Type', 'text/plain')
			// 	res.end(result.text)
			// 	break

			default:
				if (next) next()
		}
	}
	else {
		if (next) next()
	}
}
