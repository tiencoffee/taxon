chrome.runtime.onMessage.addListener((req, sender, res) => {
	if (typeof req !== "object")
		req = {type: req}
	switch (req.type) {
	case "closeTab":
		chrome.tabs.query({currentWindow: true}, tabs => {
			if (tabs.length > 1) {
				chrome.tabs.remove(sender.tab.id)
			}
		})
		break
	case "openTabs":
		chrome.tabs.query({index: sender.tab.index + 1, currentWindow: true}, ([tab]) => {
			if (tab) {
				chrome.tabs.update(tab.id, {active: true})
			}
		})
		break
	}
})
