(async function() {
	let code = await (await fetch(chrome.runtime.getURL("background.ls"))).text()
	livescript.run(code)
})()
