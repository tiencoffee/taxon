{hostname} = location
isWiki = /\bwiki[mp]edia\b/test hostname
isWikipedia = /\.wikipedia\.org$/test hostname
isImgur = /\bimgur\b/test hostname
isGoogle = /\bgoogle\b/test hostname
code = void
buttons = 0
data = ""
cropper = null
imgurSaving = no
token = ""
selection = getSelection!
preventCode = no
langViEl = null
wikiCommonEl = null
hasSubspeciesContent = no
mouseRightDownAction = null

clsData =
	["vực|siêu giới|domain|super-?kingdom" "" "",,]
	["giới|kingdom" "" "",,]
	["phân giới|sub-?kingdom" "" "",,]
	["thứ giới|infra-?kingdom" "" "",,]
	["liên ngành|siêu ngành|super-?phylum" "" "",,]
	["ngành|phylum" \KeyN \phylum,,]
	["phân ngành|sub-?phylum" "" "",,]
	["thứ ngành|infra-?phylum" "" "",,]
	["tiểu ngành|micro-?phylum" "" "",,]
	["liên lớp|siêu lớp|super-?class" \KeyS \superclass,,]
	["lớp|class" \KeyX \class,,]
	["phân lớp|sub-?class" \KeyD \subclass,,]
	["thứ lớp|infra-?class" "" "",,]
	["tiểu lớp|parv-?class" "" "",,]
	["đoàn|legion" "" "",,]
	["liên đội|super-?cohort" "" "",,]
	["đội|cohort" "" "",,]
	["tổng bộ|đại bộ|magn-?order" "" "",,]
	["liên bộ|siêu bộ|super-?order" \KeyG \superorder,,]
	["bộ|order" "KeyB" "order",,]
	["phân bộ|sub-?order" \KeyJ \suborder,,]
	["thứ bộ|infra-?order" "" "",,]
	["tiểu bộ|parv-?order" "" "",,]
	["liên họ|siêu họ|super-?family" \KeyY \superfamily \oidea]
	["họ|family" \KeyH \family \idae]
	["phân họ|sub-?family" \KeyU \subfamily \inae]
	["liên tông|super-?tribe" \Digit5 \supertribe,,]
	["tông|tribe" \KeyT \tribe \ini]
	["phân tông|sub-?tribe" \Digit6 \subtribe,,]
	["chi|genus" \KeyC \genus,,]
	["phân chi|sub-?genus" \KeyF \subgenus,,]
	["mục|section" "" "",,]
	["loạt|series" "" "",,]
	["liên loài|super-?species" "" "",,]
	["loài|species" \KeyL \species,,]
	["phân loài|sub-?species" \KeyP \subspecies,,]
	["thứ|variety" "" "",,]
	["dạng|form" "" "",,]
for cls, i in clsData
	cls.4 = i
	cls.5 = ///^(?:#{cls.0}):?\s+///i
	cls.6 = ///^(?:#{cls.0})$///i
	cls.7 = cls.3 and ///^[A-Z][a-z]#{cls.3}$///
regexSeparates =
	/[\r\n]+/
	/[\r\n]+|\s–\s|\s\-\s/
regexStartsWithClsStr = clsData.map (.0) .join \|
regexStartsWithCls = ///^(?:#regexStartsWithClsStr):?\s+///i
regexExtinct = /\b(?:tuyệt chủng|extinct|fossil)\b|†/i
regexSeparate = regexSeparates[+(hostname is \species.wikimedia.org)]
regexSubspecies = ///
	(?<=^[A-Z]\.\s*[a-z-]+\s)[a-z-]+|
	(?<=^[A-Z]\.\s*[-a-z]\.\s*)[-a-z]+|
	(?<=^[A-Z][a-z]+\s[-a-z]+\s)[-a-z]+|
	(?<=^[A-Z][a-z]+\s[-a-z]\.\s*)[-a-z]+
///
regexVirus = ///
	(?<=^[A-Z]\.\s*[a-z]\.\s*)[a-zA-Z0-9]+\s[-a-zA-Z0-9]+|
	(?<=^[A-Z][a-z]+\s[-a-z]+\s)[a-zA-Z0-9]+\s[-a-zA-Z0-9]+|
	(?<=^[A-Z]\.\s*[a-z]\.\s*)[-a-zA-Z0-9.\/]+|
	(?<=^[A-Z][a-z]+\s[a-z\-]+\s)[a-zA-Z0-9\-\/\.]+
///
regexSpecies = ///
	(?<=^[A-Z]\.\s*)[-a-z]+|
	(?<=^[A-Z][a-z]+\s)[-a-z]+
///
closestCls = clsData
	.filter (.2)
	.map ~> ".#{it.2}"
	.join \,
data = ""
sel = ""
markedEls = []
selEl = null
autoSelectText = yes

m <<<
	class: (...clses) ->
		res = []
		for cls in clses
			if Array.isArray cls
				res.push m.class ...cls
			else if cls instanceof Object
				for k, v of cls
					res.push k if v
			else if cls?
				res.push cls
		res * " "

	bind: (obj, thisArg = obj) ->
		for k, val of obj
			if typeof val is \function and val.name isnt /(bound|class) /
				obj[k] = val.bind thisArg
		obj

unique = (arr) ->
	uniqArr = []
	for v in arr
		uniqArr.push v unless uniqArr.includes v
	arr.splice 0 arr.length, ...uniqArr
	arr

copy = (text) ->
	if text?
		# el = document.createElement "textarea"
		# el.value = text
		# el.style.cssText = "position: fixed;left: 0;top: 0"
		# document.body.appendChild el
		# el.select()
		# document.execCommand "copy"
		# el.remove()
		selection.empty!
		navigator.clipboard.writeText text

selectText = (node) !->
	document.activeElement.blur!
	if document.body.createTextRange
		range = that!
			..moveToElementText node
			..select!
	else if getSelection
		range = document.createRange!
			..selectNodeContents node
		selection
			..removeAllRanges!
			..addRange range
	else
		console.warn "Trình duyệt không hỗ trợ Selection."

checkNotFocusInput = ->
	document.activeElement.localName isnt /^(?:input|textarea)$/

keypress = (codeKey, initEvt) !->
	opts = code: codeKey
	opts <<< initEvt
	evt = new KeyboardEvent \keypress opts
	dispatchEvent evt

markEl = (el, markOutline = 'solid 2px #07d') !->
	unless markedEls.includes el
		{outline, outlineOffset} = el.style
		el.style
			..outline = markOutline
			..outlineOffset = \-1px
		markedEls.push el
		setTimeout !~>
			el.style
				..outline = outline
				..outlineOffset = outlineOffset
			markedEls.splice markedEls.indexOf(el), 1
		, 400

hideChildUl = (el = selEl) !->
	el?parentElement.querySelectorAll \ul .forEach (.hidden = yes)

showChildUl = (el = selEl) !->
	el?parentElement.querySelectorAll \ul .forEach (.hidden = no)

keepITagUl = (el = selEl) !->
	if el
		ul = el.parentElement
		prop = \$_Taxonomy_keepITagUl_innerHTML
		if ul[prop]
			ul.innerHTML = that
			delete ul[prop]
		else
			ul[prop] = ul.innerHTML
			for li in ul.children
				text = li.querySelector \i .innerText
				if regexExtinct.test li.innerText
					text += " †"
				li.innerText = text
			selectText ul

fetchDetails = (ul) !->
	unless ul.TaxonomyDetails
		ul.TaxonomyDetails = yes
		for li in ul.children
			if a = li.querySelector ':scope> i> a'
				unless a.classList.contains \new
					q = a.innerText
					li.innerHTML = """
						<i>#{a.outerHTML}<i> <div class="taxonLoader"></div>
					"""
					[jsonVi, jsonEn] = await Promise.all [
						(await fetch "https://vi.wikipedia.org/api/rest_v1/page/summary/#q")json!
						(await fetch "https://en.wikipedia.org/api/rest_v1/page/summary/#q")json!
					]
					li.classList.add \TaxonomyDetails
					li.innerHTML = """
						<i>#{a.outerHTML}</i>
						&nbsp;&mdash; <b>#{jsonVi.title}</b>
						<div class="TaxonomyDetailsDesc">
							<a href="https://commons.wikimedia.org/wiki/Category:#q" target="_blank">
								<img src="#{jsonEn.thumbnail?source}">
							</a>
							<small>#{jsonVi?extract_html or ""}</small>
						<div>
					"""

notify = (html, timeout = 5000) !->
	el = document.createElement \div
		..className = \taxonNotify
		..innerHTML = html
	document.body.appendChild el
	setTimeout !~>
		el.remove!
	, timeout

openWinGetImgurToken = ->
	open do
		\https://api.imgur.com/oauth2/authorize?client_id=92ac14aabe20918&response_type=token&state=taxon
		\_blank

createCropper = (img) !->
	if cropper
		cropper.destroy!
		cropper := null
	if isGoogle
		document.querySelector \.hm60ue ?remove!
		el = document.querySelectorAll \.VSIspc
		el.1.remove! if el.length is 3
		el = document.querySelectorAll \.ZGGHx
		el.1.remove! if el.length is 3
		img = document.querySelectorAll \.n3VNCb
		img .= [* is 3 and 1 or 0]
		img.parentElement.href = \javascript:
		blob = await (await fetch "https://cors-anywhere.herokuapp.com/#{img.src}")blob!
		img.src = await new Promise (resolve) !~>
			new FileReader
				..onload = !~>
					resolve it.target.result
				..readAsDataURL blob
	else if isWiki
		document.querySelector \.mw-mmv-download-dialog ?remove!
	if img
		cropper := new Cropper img,
			checkCrossOrigin: no
			zoomable: no
			guides: no
			center: no
			ready: !->
				@cropper.setCropBoxData do
					left: 0
					top: 0
					width: 0
					height: 0

uploadImgur = ({image, type}, cb) !->
	imgurSaving := yes
	if token
		notify "Đang upload ảnh imgur..."
		formData = new FormData
			..append \image image
			..append \album \RPTWQrk
			..append \type type
		res = await fetch \https://api.imgur.com/3/image,
			method: \post
			headers:
				"Authorization": "Bearer #token"
			body: formData
		if res.ok
			res = await res.json!
			if res.status is 200
				if cropper
					cropper.destroy!
					cropper := null
				await copy " # #{res.data.id}"
				location.href = "https://imgur.com/edit?deletehash=#{res.data.deletehash}&album_id=RPTWQrk"
			else
				err = Error "Lấy thông tin ảnh imgur thất bại"
		else
			err = Error "Upload ảnh imgur thất bại"
	else
		err = Error "Chưa có token"
	if err
		notify err.message
	imgurSaving := no
	cb? err, res.data

closeTab = !->
	chrome.runtime.sendMessage \closeTab

window.addEventListener \keydown (event) !->
	return if event.repeat
	{code} := event

window.addEventListener \keypress (event) !->
	if preventCode
		code := void
		preventCode := no
	else if not event.isTrusted
		{code} := event
	{ctrlKey, shiftKey, altKey, metaKey} = event
	noModf = !ctrlKey and !shiftKey and !altKey and !metaKey
	ctrl = ctrlKey and !shiftKey and !altKey and !metaKey
	shift = !ctrlKey and shiftKey and !altKey and !metaKey
	alt = !ctrlKey and !shiftKey and altKey and !metaKey
	meta = !ctrlKey and !shiftKey and !altKey and metaKey
	if isWiki
		isKeyDownClsData = code is \Semicolon or clsData.some (.1 is code)
		if event.shiftKey
			if isKeyDownClsData
				hideChildUl!
	sel := (getSelection! + "")trim!
	if checkNotFocusInput!
		if isWiki
			if sel
				if not event.ctrlKey and document.activeElement is document.body
					if isKeyDownClsData
						data := ""
						row = sel.split regexSeparate
						lv = void
						unless event.isTrusted
							if col = row.0
								if code in <[KeyL KeyP Semicolon]>
									switch
									| clsData.find (.5.test col)
										lv = that.4
									| /^([A-Z]\.\s?[a-z]\.\s[a-z-]{2,}|[A-Z][a-z]+\s[a-z]{2,}\s[a-z-]{2,})/test col
										code := \KeyP
						if lv?
							code := ""
						else
							lv = clsData.findIndex (.1 is code)
							lv = 0 if lv < 0
						lvTab = \\t * lv
						for col, i in row
							col .= trim!
							if col.match regexExtinct
								col .= replace regexExtinct, ""
								isExtinct = yes
							else
								isExtinct = no
							col .= trim!replace regexStartsWithCls, ""
							col .= replace /^"(.+)"$/, \$1
							matched = switch code
								| \KeyP
									col.match regexSubspecies
								| \Semicolon
									col.match regexVirus
								| \KeyL
									col.match regexSpecies
								else
									col.match /^[A-Z][a-z]+/
							if matched
								matched .= 0
								if isExtinct
									matched += \*
								matched = lvTab + matched
							col = matched
							row[i] = col
						row .= filter Boolean
						row =
							...row.filter ~> not it.includes \*
							...row.filter (.includes \*)
						unique row
						data += row * \\n
						data := (\\n + data)
							.replace /[\r\n]?\t*\bnull\b/g ""
							.replace /\ /g " "
						unless event.isTrusted
							if code is \KeyL
								unless data.trim!
									col = row.0
									if clsData.find (.7?test col)
										keypress that.1
									else
										keypress \KeyC
					else
						switch code
						| \KeyQ
							if noModf
								sel .= replace regexStartsWithCls, ""
								data := " # " + sel.charAt(0)toUpperCase! + sel.slice 1
						| \Delete
							if noModf
								hideChildUl!
						| \Backspace
							if noModf
								keepITagUl!
						| \KeyZ
							if noModf
								data := sel
					copy data if data
			else
				switch code
				| \KeyZ
					if noModf
						history.back!
				| \KeyX
					if noModf
						history.forward!
				| \KeyC
					if noModf
						if wikiCommonEl
							wikiCommonEl.click!
						else if document.URL.includes \commons.wikimedia.org
							history.back!
				| \KeyS
					if noModf
						if link = document.querySelector '.wb-otherproject-species> a'
							link.click!
						else if document.URL.includes \species.wikimedia.org
							history.back!
				| \KeyD
					if noModf
						getLink = ~>
							document.querySelector "a.interlanguage-link-target[hreflang=#it]"
						if getLink \vi or getLink \en
							that.click!
			switch code
			| \KeyE
				if noModf
					if data
						if data.includes \*
							data .= replace /\*/g ""
						else
							data .= replace /([^*])\n/g \$1*\n
							unless data.endsWith \*
								data += \*
						copy data
			| \KeyW
				if noModf
					closeTab!
			| \F1
				if noModf
					event.preventDefault!
					text = clsData
						.map ~> it.0.split(\|)join(" | ") + it.1
						.join ": "
					alert text
			| \KeyA
				if noModf
					not:= autoSelectText
			| \Backquote
				if noModf
					regexSeparate := regexSeparates.1
			| \KeyV
				if noModf
					if el = document.querySelector 'h2> #Species, h3> #Species'
						el .= parentElement
						loop
							break unless el = el.nextElementSibling
							break if el.localName is \ul
							if el2 = el.querySelector \ul
								el = el2
								break
						if el
							selectText el
							keypress \KeyL
							markEl el
					else if el = document.querySelector 'table.infobox.biota .species'
						selectText el
						keypress \KeyL
						markEl el
			| \Digit2 \Digit3
				if noModf
					if h3s = document.querySelectorAll ".mw-parser-output> h#{code.5}"
						text = ""
						for h3 in h3s
							ul = h3
							do
								ul .= nextElementSibling
							until ul.localName is \ul
							text += \\n + "\t"repeat(29) + (h3.innerText is /[A-Z][a-z]+/)0
							for li in ul.children
								species = li.querySelector \i .innerText.split " " .1
								text += \\n + "\t"repeat(34) + species
								if ul2 = li.querySelector \ul
									text += \\n + "\t"repeat(35) + species
									for li2 in ul2.children
										subspecies = li2.querySelector \i .innerText.split " " .2
										unless species is subspecies
											text += \\n + "\t"repeat(35) + subspecies
						copy text
			| \Digit4
				if noModf
					if el = document.querySelector '.mw-parser-output> h2'
						text = ""
						do
							switch el.localName
							| \h2
								text += \\n + "\t"repeat(25) + (el.innerText is /[A-Z][a-z]+/)0
							| \h3
								text += \\n + "\t"repeat(27) + (el.innerText is /[A-Z][a-z]+/)0
							| \ul
								for li in el.children
									text += \\n + "\t"repeat(29) + (li.innerText is /[A-Z][a-z]+/)0
						while el .= nextElementSibling
						copy text
			| \KeyO
				text = await navigator.clipboard.readText!
				link = "https://en.wikipedia.org/wiki/#text"
				if shift
					open link
				else
					location.href = link
			if shift
				showChildUl!
		else if isImgur
			if location.pathname is \/edit
				switch code
				| \KeyS
					if noModf
						document.querySelector \#save .click!
				| \KeyR
					if noModf
						document.querySelector \#reset-crop .click!
			else
				switch code
				| \KeyE
					if noModf
						document.querySelector \.post-image-option.help>a .click!
			switch code
			| \KeyZ
				if noModf
					history.back!
			| \KeyW
				if noModf
					closeTab!
		switch code
		| \KeyN
			if isGoogle
				if noModf
					createCropper!
		| \KeyM
			unless imgurSaving
				if noModf
					if document.contains cropper?element
						image = cropper.getCroppedCanvas!toDataURL \image/jpeg
						image .= replace "data:image/jpeg;base64," ""
						type = \base64
					else
						if isGoogle
							img = document.querySelectorAll \.n3VNCb .1
							image = img.src
							type = \URL
					if image
						uploadImgur {image, type}
		| \KeyK
			if noModf
				if confirm "Lấy token imgur mới?"
					openWinGetImgurToken!
		| \Escape
			if cropper
				if noModf
					cropper.destroy!
					cropper := null
	code := void
	buttons := 0

window.addEventListener \mousedown (event) !->
	selEl := null
	sel := (getSelection! + "")trim!
	{buttons} := event
	{target} = event
	{localName} = target
	if checkNotFocusInput!
		switch event.which
		| 3
			switch
			| isImgur
				if localName is \img
					aEl = document.createElement \a
						..href = target.src
					hash = aEl.pathname.slice 1 8
					if event.altKey
						copy hash
					else
						prefix event.shiftKey and " | " or " # "
						copy prefix + hash
					markEl target
			| isGoogle
				if localName is \img
					unless event.ctrlKey
						copy target.src
						markEl target
			| isWiki
				switch
				| localName is \img
					switch code
					| \KeyN
						createCropper target
						preventCode := yes
					| \KeyM
						unless imgurSaving
							uploadImgur do
								image: target.src
								type: \URL
						preventCode := yes
					else
						unless event.ctrlKey
							imgUrl = target.src
							if event.altKey
								copy imgUrl
							else
								switch
								| /\/\d+px-.+/test imgUrl
									imgUrl = imgUrl
										.replace \https://upload.wikimedia.org/wikipedia/commons/thumb ""
										.replace /\/\d+px-.+/ ""
								| /-\d+px-.+/.test imgUrl
									imgUrl .= replace /-\d+px-/ \-220px-
								prefix = event.shiftKey and " | " or " # "
								subfix = {
									KeyF: \fossil
									KeyR: \restoration
									KeyC: \reconstruction
									KeyE: \exhibit
									KeyD: \drawing
									KeyH: \holotype
									KeyS: \skull
									KeyK: \skeleton
									KeyJ: \jaw
									KeyM: \mandible
									KeyI: \illustration
									KeyP: \specimen
								}[code] or ""
								if subfix
									subfix = " ; #subfix"
									preventCode := yes
								copy prefix + imgUrl + subfix
							markEl target
				| el2 = target.closest closestCls
					code2 = clsData.find (.2 is el2.className) .1
					selectText target
					keypress code2
					markEl target
				| sel
					keypress \KeyL
				| localName is \li
					if event.altKey
						mouseRightDownAction := [\altLis target]
					else
						hideChildUl target
						unless target.parentElement.firstElementChild.querySelector 'i:first-child> a'
							keepITagUl target
						selectText target.parentElement
						code2 = \KeyL
						cond =
							target.closest \.infobox.biota and
							target.closest \tr .previousElementSibling.innerText is /Genus|Genera/
						unless cond
							if prevElSibl = target.parentElement?previousElementSibling
								cond =
									prevElSibl.querySelector \#Genera or
									prevElSibl.previousElementSibling?querySelector \#Genera
						if cond
							code2 = \KeyC
						keypress code2
						markEl target.parentElement
						# fetchDetails target.parentElement
				| target.closest \.infobox.biota
					if event.altKey
						mouseRightDownAction := [\altLisInfoboxBiota target]
					else if a = target.closest 'a:not(.selflink)'
						mouseRightDownAction := [\aInfoboxBiota a]
					else
						code2 = \KeyL
						if td = target.closest \td
							rank = td.previousElementSibling?
								.innerText
								.trim!
								.toLowerCase!
								.replace /[^a-z]/g ""
							if rank
								if cls = clsData.find (.6.test rank)
									code2 = cls.1
						if td.querySelector \a
							td = that
						selectText td
						keypress code2
						markEl td
				| localName in <[th td]> and (table = target.closest \table)
					if event.ctrlKey =>
					else
						if event.shiftKey
							tds = [...table.rows]
								.filter (tr) ~>
									cells = [...tr.cells]
									if cells.every (.localName is \th)
										no
									else
										for cell in cells
											if cell.rowSpan > 1
												cell.remove!
										yes
								.map (.cells[target.cellIndex])
						else
							tds = [...table.rows]
								.slice target.parentElement.rowIndex
								.map (.cells[target.cellIndex])
						ul = document.createElement \ul
							..className = \pointer-events-none
							..innerHTML = tds
								.map ~> "<li>#{it.innerHTML}</li>"
								.join ""
						table.replaceWith ul
						selectText ul
						keypress code || \KeyL
						markEl ul
						# fetchDetails ul
				| el = target.closest '#firstHeading,b,h1,h2,h3,h4,h5,h6'
					selectText el
					keypress \KeyQ
					markEl el
, yes

window.addEventListener \mouseup (event) !->
	selEl := null
	{target} = event
	{localName} = target
	switch event.which
	| 1
		switch
		| isWiki
			if event.detail is 1
				if /^(li|a|b|i)$/test localName or
				localName is \p and target.closest \.infobox.biota
					unless event.altKey
						if autoSelectText
							if localName isnt \a or localName is \a and not target.href
								selectText target.parentElement
								selEl := target
		| isImgur
			if event.detail is 1
				if localName is \img
					target
						.closest \.post-image-container
						.querySelector \.post-image-option.help>a
						.click!
	| 3
		if isWiki
			if mouseRightDownAction
				[type, ...args] = mouseRightDownAction
				switch type
				| \altLis
					[target2] = args
					prop = \$_Taxonomy_linkOpened
					i = 0
					hasOpen = no
					for li in target2.parentElement.children
						unless li[prop]
							li[prop] = yes
							if a = li.querySelector ':scope> i> a:not(.new), :scope> a:not(.new)'
								a.style.textDecoration = \underline
								unless event.shiftKey
									hasOpen = yes
									open a.href
								break if ++i is 10
					unless i
						markEl target2.parentElement, 'solid 2px #f43'
					if hasOpen
						chrome.extension.sendMessage \openTabs
				| \altLisInfoboxBiota
					[target2] = args
					prop = \$_Taxonomy_linkOpened
					i = 0
					hasOpen = no
					for li in target2.children
						unless li[prop]
							li[prop] = yes
							if a = li.querySelector ':scope> a:not(.new)'
								a.style.textDecoration = \underline
								unless event.shiftKey
									hasOpen = yes
									open a.href
								break if ++i is 10
					unless i
						markEl target2, 'solid 2px #f43'
					if hasOpen
						chrome.extension.sendMessage \openTabs
				| \aInfoboxBiota
					[a] = args
					open a.href
				mouseRightDownAction := null
			else
				if localName is \a and not target.classList.contains \selflink
					target.style.textDecoration = \underline
					open target.href
			if el = document.querySelector \ul.pointer-events-none
				el.classList.remove \pointer-events-none
	buttons := 0 unless code
, yes

window.addEventListener \contextmenu (event) !->
	if event.x
		event.preventDefault!
, yes

unless isImgur
	chrome.storage.sync.get [\token \tokenTime] (result) !~>
		{token} := result
		{tokenTime} = result
		unless token and tokenTime + 864e5 * 7 > Date.now!
			win = openWinGetImgurToken!
			timer = setInterval !~>
				if win.closed
					clearInterval timer
					chrome.storage.sync.get [\token] (result) !~>
						{token} := result
			, 1000

window.addEventListener \load !->
	switch
	| isWiki
		if isWikipedia
			if el = document.querySelector \#References
				el .= parentElement
				do
					el2 = el.nextElementSibling
					el.remove!
				while el = el2
			if langViEl := document.querySelector 'a.interlanguage-link-target[hreflang=vi]'
				page = (langViEl.href is /[^\/]+$/)0
			if wikiCommonEl := document.querySelector '.wb-otherproject-commons> a'
				el = document.createElement \link
				el.rel = \prerender
				el.href = wikiCommonEl.href
				document.head.appendChild el
			hasSubspeciesContent := content.innerText.includes \subspecies
			if page
				summary = await (await fetch "https://vi.wikipedia.org/api/rest_v1/page/summary/#page")json!
			App = m.bind do
				view: ->
					m \.column.taxonRightSide,
						m \.row-2.p-3,
							if hasSubspeciesContent
								m \.text-green "Phân loài"
							if wikiCommonEl
								m \.text-green "Wiki common"
						if summary
							m \.col.px-3.column.f-center.scroll-y,
								m \.mt-1.mb-3.taxonSummaryTitle,
									m \b summary.title
								if summary.thumbnail?source
									m \img.taxonSummaryImg src: that
								else
									m \p.text-red.text-center "Không có hình ảnh"
								m \p.taxonSummaryExtract,
									m.trust summary.extract_html
						else
							m \.col.text-red.text-center "Không có tiếng Việt"
			el = document.createElement \div
			document.body.appendChild el
			m.mount el, App
	| isImgur
		if location.search is \?state=taxon
			token := /access_token=([a-z0-9]+)/exec location.hash .1
			chrome.storage.sync.set do
				token: token
				tokenTime: Date.now!
				closeTab
