chrome.runtime.onMessage.addListener (req, sender, res) !~>
	unless typeof! req is \Object
		req = type: req
	switch req.type
	| \closeTab
		chrome.tabs.query currentWindow: yes, (tabs) !~>
			if tabs.length > 1
				chrome.tabs.remove sender.tab.id
	| \openTabs
		chrome.tabs.query index: sender.tab.index + 1, currentWindow: yes, ([tab]) !~>
			if tab
				chrome.tabs.update tab.id, active: yes
