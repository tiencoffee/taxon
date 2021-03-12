urlOpens = []
urlOpensIndex = 0
urlOpensTabIds = {}

createUrlOpenTab = (active) ~>
	urlOpen = urlOpens[urlOpensIndex++]
	chrome.tabs.create do
		active: active
		url: urlOpen
		(tab) !~>
			urlOpensTabIds[tab.id] = yes

chrome.runtime.onMessage.addListener (req, sender, res) !~>
	unless typeof! req is \Object
		req = act: req

	switch req.act
	| \closeTab
		chrome.tabs.query currentWindow: yes, (tabs) !~>
			if tabs.length > 1
				chrome.tabs.remove sender.tab.id

	| \openUrls
		urlOpens := req.urls
		urlOpensIndex := 0
		urlOpensTabIds := {}
		for i til 10
			if urlOpensIndex < urlOpens.length
				createUrlOpenTab not i

	| \stopOpenUrls
		for tabId in urlOpensTabIds
			chrome.tabs.remove tabId
		urlOpens := []
		urlOpensIndex := 0
		urlOpensTabIds := {}

chrome.tabs.onRemoved.addListener (tabId, removeInfo) !~>
	if urlOpensTabIds[tabId]
		if urlOpensIndex < urlOpens.length
			createUrlOpenTab no
		else
			urlOpens := []
			urlOpensIndex := 0
			urlOpensTabIds := {}
