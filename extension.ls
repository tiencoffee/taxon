App =
	oninit: !->
		for k, val of @
			@[k] = val.bind @ if typeof val is \function
		@cssUnitless =
			animationIterationCount: yes
			borderImageOutset: yes
			borderImageSlice: yes
			borderImageWidth: yes
			boxFlex: yes
			boxFlexGroup: yes
			boxOrdinalGroup: yes
			columnCount: yes
			columns: yes
			flex: yes
			flexGrow: yes
			flexPositive: yes
			flexShrink: yes
			flexNegative: yes
			flexOrder: yes
			gridArea: yes
			gridRow: yes
			gridRowEnd: yes
			gridRowSpan: yes
			gridRowStart: yes
			gridColumn: yes
			gridColumnEnd: yes
			gridColumnSpan: yes
			gridColumnStart: yes
			fontWeight: yes
			lineClamp: yes
			lineHeight: yes
			opacity: yes
			order: yes
			orphans: yes
			tabSize: yes
			widows: yes
			zIndex: yes
			zoom: yes
			fillOpacity: yes
			floodOpacity: yes
			stopOpacity: yes
			strokeDasharray: yes
			strokeDashoffset: yes
			strokeMiterlimit: yes
			strokeOpacity: yes
			strokeWidth: yes
		@ranks =
			* name: \domain
				prefixes:
					\domain
					\domains
					\super-?kingdom
					\super-?kingdoms
					\super-?regnum
					\super-?regna
					\vực
					"siêu giới"
			* name: \kingdom
				prefixes:
					\kingdom
					\kingdoms
					\regnum
					\regna
					\giới
			* name: \subkingdom
				prefixes:
					\sub-?kingdom
					\sub-?kingdoms
					\sub-?regnum
					\sub-?regna
					"phân giới"
			* name: \infrakingdom
				prefixes:
					\infra-?kingdom
					\infra-?kingdoms
					\infra-?regnum
					\infra-?regna
					"thứ giới"
			* name: \superphylum
				prefixes:
					\super-?phylum
					\super-?division
					\super-?phylums
					\super-?divisions
					\super-?divisio
					\super-?phyla
					\super-?divisiones
					"liên ngành"
					"siêu ngành"
			* name: \phylum
				prefixes:
					\phylum
					\division
					\phylums
					\divisions
					\divisio
					\phyla
					\divisiones
					\ngành
				suffixes: <[ophyta mycota]>
			* name: \subphylum
				prefixes:
					\sub-?phylum
					\sub-?division
					\sub-?phylums
					\sub-?divisions
					\sub-?divisio
					\sub-?phyla
					\sub-?divisiones
					"phân ngành"
				suffixes: <[phytina mycotina]>
			* name: \infraphylum
				prefixes:
					\infra-?phylum
					\infra-?division
					\infra-?phylums
					\infra-?divisions
					\infra-?divisio
					\infra-?phyla
					\infra-?divisiones
					"thứ ngành"
			* name: \parvphylum
				prefixes:
					\parv-?phylum
					\micro-?phylum
					\parv-?phylums
					\micro-?phylums
					\parv-?divisio
					\micro-?divisio
					\parv-?phyla
					\micro-?phyla
					\parv-?divisiones
					\micro-?divisiones
					"tiểu ngành"
			* name: \superclass
				prefixes:
					\super-?class
					\super-?classes
					\super-?classis
					"liên lớp"
					"siêu lớp"
			* name: \class
				prefixes:
					\class
					\classes
					\classis
					\lớp
				suffixes: <[opsida phyceae mycetes]>
			* name: \subclass
				prefixes:
					\sub-?class
					\sub-?classes
					\sub-?classis
					"phân lớp"
				suffixes: <[phycidae mycetidae]>
			* name: \infraclass
				prefixes:
					\infra-?class
					\infra-?classes
					\infra-?classis
					"thứ lớp"
			* name: \parvclass
				prefixes:
					\parv-?class
					\parv-?classes
					\parv-?classis
					"tiểu lớp"
			* name: \legion
				prefixes:
					\legion
					\legions
					\đoàn
			* name: \supercohort
				prefixes:
					\super-?cohort
					\super-?cohorts
					\super-?cohors
					\super-?cohortes
					"liên đội"
			* name: \cohort
				prefixes:
					\cohort
					\cohorts
					\cohors
					\cohortes
					\đội
			* name: \magnorder
				prefixes:
					\magn-?order
					\mega-?order
					\magn-?orders
					\mega-?orders
					\magn-?ordo
					\mega-?ordo
					\magn-?ordines
					\mega-?ordines
					"tổng bộ"
					"đại bộ"
			* name: \superorder
				prefixes:
					\super-?order
					\super-?orders
					\super-?ordo
					\super-?ordines
					"liên bộ"
					"siêu bộ"
				suffixes: <[anae]>
			* name: \order
				prefixes:
					\order
					\orders
					\ordo
					\ordines
					\bộ
				suffixes: <[iformes ales]>
			* name: \suborder
				prefixes:
					\sub-?order
					\sub-?orders
					\sub-?ordo
					\sub-?ordines
					"phân bộ"
				suffixes: <[ineae]>
			* name: \infraorder
				prefixes:
					\infra-?order
					\infra-?orders
					\infra-?ordo
					\infra-?ordines
					"thứ bộ"
				suffixes: <[aria]>
			* name: \parvorder
				prefixes:
					\parv-?order
					\parv-?orders
					\parv-?ordo
					\parv-?ordines
					"tiểu bộ"
			* name: \superfamily
				prefixes:
					\super-?family
					\super-?families
					\super-?familia
					\super-?familiae
					"liên họ"
					"siêu họ"
				suffixes: <[oidea acea]>
			* name: \family
				prefixes:
					\family
					\families
					\familia
					\familiae
					\họ
				suffixes: <[idae aceae]>
			* name: \subfamily
				prefixes:
					\sub-?family
					\sub-?families
					\sub-?familia
					\sub-?familiae
					"phân họ"
				suffixes: <[inae oideae]>
			* name: \supertribe
				prefixes:
					\super-?tribe
					\super-?tribes
					\super-?tribus
					"liên tông"
			* name: \tribe
				prefixes:
					\tribe
					\tribes
					\tribus
					\tông
				suffixes: <[ini eae]>
			* name: \subtribe
				prefixes:
					\sub-?tribe
					\sub-?tribes
					\sub-?tribus
					"phân tông"
			* name: \genus
				prefixes:
					\genus
					\genera
					\chi
			* name: \subgenus
				prefixes:
					\sub-?genus
					\sub-?genera
					"phân chi"
			* name: \section
				prefixes:
					\section
					\sections
					\sectio
					\sectiones
					\mục
			* name: \series
				prefixes:
					\series
					\loạt
			* name: \superspecies
				prefixes:
					\super-?species
					"liên loài"
			* name: \species
				prefixes:
					\species
					\loài
			* name: \subspecies
				prefixes:
					\sub-?species
					"phân loài"
			* name: \variety
				prefixes:
					\variety
					\varieties
					\varietas
					\thứ
			* name: \form
				prefixes:
					\form
					\forms
					\forma
					\dạng
		@ranks.prefixes = []
		@ranks.suffixes = []
		for rank, i in @ranks
			rank.lv = i
			rank.tab = \\t * i
			for text in rank.prefixes
				prefix =
					text: text
					regex: ///#text///i
					startsRegex: ///^#text///i
					rank: rank
				@ranks.prefixes.push prefix
			if rank.suffixes
				for text in rank.suffixes
					suffix =
						text: text
						regex: ///[A-Z][a-z]*#text///
						startsRegex: ///^[A-Z][a-z]*#text///
						rank: rank
					@ranks.suffixes.push suffix
			@ranks[rank.name] = rank
		@ranks.prefixes.sort (a, b) ~>
			b.text.split(" ")length - a.text.split(" ")length or
			b.text.length - a.text.length
		@ranks.suffixes.sort (a, b) ~>
			b.text.length - a.text.length
		@regexes = {}
			..prefixesStr = @ranks.prefixes.map (.text) .join \|
			..startsPrefixes = ///^(#{..prefixesStr})[ \xa0:]+///i
			..extinct = /\b(tuyệt chủng|extinct|fossil)\b|†/i
			..incSedis = /\b(incertae sedis|inc\. sedis|uncertain)\b/i
		@data = null
		@notifies = []
		@modals = []
		@selection = getSelection!
		@token = null
		@album = null
		@isContextMenu = no
		@resetCombo!
		@els = {}
		window.addEventListener \mousedown @onmousedown, yes
		window.addEventListener \mouseup @onmouseup, yes
		window.addEventListener \contextmenu @oncontextmenu, yes
		window.addEventListener \keydown @onkeydown, yes
		window.addEventListener \keyup @onkeyup, yes
		window.addEventListener \visibilitychange @onvisibilitychange, yes
		unless t.imgur
			chrome.storage.local.get [\token \tokenTime \album] ({@token, tokenTime, @album}) !~>
				unless @token and tokenTime + 6048e5 > Date.now!
					await @getImgurToken!
				unless @album
					until await @getImgurAlbum! =>
		if t.wiki
			@summ = null
			@els
				..viLang = document.querySelector ".interlanguage-link-target[lang=vi]"
				..enLang = document.querySelector ".interlanguage-link-target[lang=en]"
				..commons = document.querySelector ".wb-otherproject-commons> a"
				..species = document.querySelector ".wb-otherproject-species> a"
				..infoboxImg = document.querySelector ".infobox.biota a.image> img, .infobox.taxobox a.image> img"
				..infoboxLinkImg = ..infoboxImg?parentElement
			if el = document.querySelector '
			#Notes,#References,#External_links,#Reference\\/External_Links,
			#Chú_thích,#Tham_khảo,#Liên_kết_ngoài'
				el .= parentElement
				do
					nextEl = el.nextElementSibling
					el.remove!
				while el = nextEl
			if @els.infoboxLinkImg
				@prerender that.href
			if @els.commons
				@prerender that.href
			if @els.viLang
				@summ = yes
				q = that.href.split \/ .[* - 1]
				@summ = await (await fetch "https://vi.wikipedia.org/api/rest_v1/page/summary/#q")json!
				m.redraw!
		else if t.imgur
			if location.search is \?state=taxon
				@token = /access_token=([a-z\d]+)/exec location.hash .1
				chrome.storage.local.set do
					token: @token
					tokenTime: Date.now!
					@closeTab

	oncreate: !->
		if t.wiki
			if el = document.querySelector \#toc
				_toc.appendChild el

	class: (...classes) ->
		res = []
		for cls in classes
			if Array.isArray cls
				res.push @class ...cls
			else if cls instanceof Object
				for k, v of cls
					res.push k if v
			else if cls?
				res.push cls
		res * " "

	style: (...styls) ->
		res = {}
		for styl in styls
			if Array.isArray styl
				styl = @style ...styl
			if styl instanceof Object
				for k, val of styl
					res[k] = val
					res[k] += \px if not @cssUnitless[k] and +val
		res

	upperFirst: (text) ->
		text.charAt 0 .toUpperCase! + text.substring 1

	table: (table) ->
		grid = []
		for row, y in table.rows
			for cell, x in row.cells
				rowSpan = cell.rowSpan
				colSpan = cell.colSpan
				while grid[x]?[y]? => x++
				for i from x til x + colSpan
					resRow = grid[][i]
					for j til rowSpan
						resRow.row = row
						resRow[y + j] = if i is x and not j => cell else no
		grid.filter (.length)

	tableCol: (td) ->
		table = td.closest \table
		grid = @table table
		console.log grid
		col = grid.find (.includes td)
		col
			.slice col.indexOf td
			.filter Boolean

	findRank: (kind, fn) ->
		if typeof kind is \function
			[kind, fn] = [, kind]
		ranks = kind and @ranks[kind] or @ranks
		if rank = ranks.find fn
			rank = rank.rank if kind
			rank

	resetCombo: !->
		@combo = ""
		@lastCombo = void
		@modfCombo = ""
		@target = null

	makeModfCombo: (event) !->
		@modfCombo = ""
		@modfCombo += \Ctrl+ if event.ctrlKey
		@modfCombo += \Shift+ if event.shiftKey
		@modfCombo += \Alt+ if event.altKey
		@modfCombo += \Meta+ if event.metaKey

	onmousedown: (event) !->
		{which, target} = event
		event.preventDefault! if event.shiftKey
		@lastCombo = which
		which = [, \LMB \MMB \RMB][which]
		@makeModfCombo event
		@combo += (@combo and \+ or '') + which
		@target = target

	onmouseup: (event) !->
		if @lastCombo is event.which
			@oncombo event

	oncontextmenu: (event) !->
		if @isContextMenu
			@isContextMenu = no
		else
			event.preventDefault!

	onkeydown: (event) !->
		unless event.repeat
			{code, key} = event
			@lastCombo = code
			if event.altKey and code in [\KeyE \KeyF]
				event.preventDefault!
			if key in <[Control Shift Alt Meta]>
				if @combo
					@resetCombo!
			else
				@makeModfCombo event
				code -= /^(Key|Digit)/
				@combo += (@combo and \+ or '') + code

	onkeyup: (event) !->
		if @lastCombo is event.code
			@oncombo event

	onvisibilitychange: (event) !->
		@resetCombo!

	oncombo: (event) !->
		el = document.activeElement
		if @combo and el.localName not in <[input textarea select]> and not el.isContentEditable
			@combo = @modfCombo + @combo
			sel = (@selection + "")trim!
			@doCombo @combo, @target, sel, event, []
		@resetCombo!

	mark: (els) !->
		els = [els] unless \length of els
		for el in els
			rects = el.getClientRects!
			{borderRadius} = getComputedStyle el
			borderRadius = \4px if parseInt(borderRadius) < 4
			for {x, y, width, height} in rects
				markEl = document.createElement \div
				markEl.className = \_mark
				document.body.appendChild markEl
				anim = markEl.animate do
					* left: [x + \px, x - 3 + \px]
						top: [y + \px, y - 3 + \px]
						width: [width + \px, width + 6 + \px]
						height: [height + \px, height + 6 + \px]
						borderRadius: [borderRadius, borderRadius]
						background: [\#07d2 \#07d0]
						boxShadow: ['0 0 0 2px #07d' '0 0 0 2px #07d2']
					* duration: 150
				anim.onfinish = markEl~remove

	emptySel: !->
		@selection.removeAllRanges!

	copy: (text) ->
		navigator.clipboard.writeText text if text

	openLinksExtract: (targets, noOpen) ->
		count = 0
		@extract targets,
			link: (target, link) !~>
				unless target.dataset.openedLi
					if count < 10
						target.dataset.openedLi = 1
						if link
							unless link.classList.contains \new
								link.dataset.openedA = 1
								unless noOpen
									window.open link.href
								count++
		if count
			unless noOpen
				chrome.runtime.sendMessage \openTabs
		else
			@notify "Đã mở hết link"

	prerender: (url) !->
		link = document.createElement \link
		link.rel = \prerender
		link.href = url
		document.head.appendChild link

	openTabGetImgurToken: ->
		window.open do
			\https://api.imgur.com/oauth2/authorize?client_id=92ac14aabe20918&response_type=token&state=taxon

	closeTab: ->
		chrome.runtime.sendMessage \closeTab

	readAsBase64: (file) ->
		new Promise (resolve) !~>
			reader = new FileReader
			reader.onload = !~>
				resolve it.target.result - /^data:[a-z\d-]+\/[a-z\d-]+;base64,/
			reader.readAsDataURL file

	readCopiedImgBlob: ->
		[item] = await navigator.clipboard.read!
		if item?types.0.startsWith \image/
			item.getType item.types.0

	uploadImgur: (image, type) ->
		if @token and @album
			{album} = @
			notify = @notify "Đang upload ảnh Imgur" -1
			formData = new FormData
				..append \image image
				..append \album album
				..append \type type
			res = await fetch \https://api.imgur.com/3/image,
				method: \post
				headers:
					"Authorization": "Bearer #@token"
				body: formData
				background: yes
			if res.ok
				res = await res.json!
				if res.success
					{id, deletehash} = res.data
					await @copy " # #id"
					notify.update "Đã upload ảnh Imgur: #id"
					if type is \URL
						location.href = "https://imgur.com/edit?deletehash=#deletehash&album_id=#album"
				else
					notify.update "Upload ảnh Imgur thất bại"
			else
				notify.update "Không thể upload ảnh Imgur"
		else
			@notify "Chưa có token hoặc album"

	modalGetAlbums: ->
		new Promise (resolve) !~>
			if @token
				res = await m.request \https://api.imgur.com/3/account/tiencoffee/albums,
					headers:
						"Authorization": "Bearer #@token"
					background: yes
				if res.success
					albums = res.data
					album = await @modal "Chọn album Imgur",, (modal) ~>
						m \._row6,
							albums.map (album) ~>
								m \._col._p2._column._center._round8._hover,
									class: @class do
										"_active": @album is album.id
									style: @style do
										width: 80
									onclick: !~>
										modal.close album.id
									m \img._round6,
										src: "https://i.imgur.com/#{album.cover}s.png"
										width: 48
										height: 48
									m \small album.images_count
									m \small album.privacy
									m \small album.title
							m \._col._p2._column._center._round8._hover,
								onclick: !~>
									if newAlbum = await @modalCreateAlbum!
										albums.push newAlbum
										m.redraw!
								m \h1._border0 \+
								m \small "Tạo album"
					resolve album
				else
					@notify "Lấy album Imgur thất bại"
			else
				resolve!

	modalCreateAlbum: ->
		new Promise (resolve) !~>
			data = await @modal "Tạo album Imgur",, (modal) ~>
				m \form,
					onsubmit: (event) !~>
						event.preventDefault!
						if @token
							formData = new FormData
								..title = event.target.title.value
								..privacy = \hidden
							res = await m.request \https://api.imgur.com/3/album,
								method: \post
								headers:
									"Authorization": "Bearer #@token"
								body: formData
								background: yes
							if res.success
								modal.close res.data
							else
								@notify "Tạo album Imgur thất bại"
					m \p,
						m \div "Tên album:"
						m \input._mt2,
							name: \title
							required: yes
						m \button._mt2 \OK
			resolve data

	getImgurToken: ->
		new Promise (resolve) !~>
			tab = @openTabGetImgurToken!
			timer = setInterval !~>
				if tab.closed
					clearInterval timer
					chrome.storage.local.get [\token] ({@token}) !~>
						@notify "Đã đặt token Imgur: #@token"
						resolve @token
			, 1000

	getImgurAlbum: ->
		new Promise (resolve) !~>
			album = await @modalGetAlbums!
			if album
				chrome.storage.local.set {album} !~>
					@album = album
					@notify "Đã đặt album Imgur: #@album"
					resolve album
			else
				resolve!

	notify: (html, ms) ->
		notify =
			html: ""
			ms: 0
			timer: 0
			update: (html, ms = 2000) !~>
				notify.html? = html
				notify.ms = ms
				clearTimeout notify.timer
				if ms >= 0
					notify.timer = setTimeout !~>
						@notifies.splice @notifies.indexOf(notify), 1
						m.redraw!
					, ms
				m.redraw!
		@notifies.push notify
		notify.update html, ms
		notify

	modal: (title, width, view) ->
		new Promise (resolve) !~>
			modal =
				title: title
				width: width
				view: view
				close: (val) !~>
					@modals.splice @modals.indexOf(modal), 1
					resolve val
					m.redraw!
			@modals.push modal
			m.redraw!

	extract: (targets, opts = {}, parent, items) ->
		if typeof targets is \string
			targets = targets
				.trim!
				.split /\n+/
				.filter (.trim!)
		unless \length of targets
			targets = [targets]
		targets = Array.from targets
		opts = {
			notMatchText: \?
			deep: no
			...opts
		}
		unless parent
			items = []
		notMatchTab = void
		formatItems = (items) !~>
			if items.length
				if parent
					if items.every (.0.extinct)
						for item in items
							item.0.extinct = ""
						parent.extinct = \*
			items.sort (a, b) ~>
				a.0.extinct.length - b.0.extinct.length or
				(a.0.text is \?) - (b.0.text is \?)
		for target, i in targets
			isElTarget = target instanceof Element
			text = void
			if isElTarget
				targetText = target.innerText
					.trim!
					.split \\n 1 .0
					.trim!
			else
				targetText = target.trim!
			extinct = parent?extinct ? ""
			unless extinct
				if @regexes.extinct.test targetText
					extinct = \*
			targetText = targetText
				.replace @regexes.extinct, ""
				.trim!
			tab = void
			if opts.tab?
				tab = opts.tab
			if isElTarget
				links = target.querySelectorAll ":scope> i> a, :scope> a"
				if links.length
					for link in links
						innerText = link.innerText.trim!
						if innerText is \†
							link.dataset.excl = 1
						else
							opts.link? target, link
				el = target.querySelector ":scope> i> a:not(data-excl)"
				el ?= target.querySelector ":scope> i"
				el ?= target.querySelector ":scope> a:not(data-excl)"
				text = el?innerText
			if tab
				rank = @findRank (.tab is tab)
			else
				rank = @findRank \prefixes (.startsRegex.test targetText)
			text ?= targetText
			text = text
				.replace @regexes.startsPrefixes, ""
				.replace /["']/g ""
			if /cf\.|sp\./ is text
				continue
			rank ?= @findRank \suffixes (.startsRegex.test text)
			tab = rank?tab ? ""
			notMatchTab ?= tab
			if rank
				switch
				| rank.lv is 35
					if matched = /^([A-Z][a-z]+|[A-Z]\.)\s([a-z-]{2,}|[a-z]\.)\s([a-z-]{2,})/ is text
						text = matched.3
					else
						text = opts.notMatchText
				| rank.lv is 34
					if matched = /^([A-Z][a-z]+|[A-Z]\.)\s([a-z-]{2,})/ is text
						text = matched.2
					else
						text = opts.notMatchText
				| @regexes.incSedis.test text
					text = \?
				| matched = /^([A-Z][a-z]+)/ is text
					text = matched.1
				else
					text = opts.notMatchText
			else
				switch
				| /\b(incertae sedis|uncertain)\b/i is text
					text = \?
					tab = notMatchTab
				| matched = /^([A-Z][a-z]+|[A-Z]\.)\s([a-z-]{2,}|[a-z]\.)\s([a-z-]{2,})/ is text
					text = matched.3
					tab = @ranks.subspecies.tab
				| matched = /^([A-Z][a-z]+|[A-Z]\.)\s([a-z-]{2,})/ is text
					text = matched.2
					tab = @ranks.species.tab
				| matched = /^([A-Z][a-z]+)/ is text
					text = matched.1
					tab = @ranks.genus.tab
				else
					text = opts.notMatchText
					tab = notMatchTab
			item =
				* tab: tab
					text: text
					extinct: extinct
				* []
			if i
				if tab.length < items.0.0.tab.length
					notMatchTab = tab
					newItem =
						* tab: tab
							text: \?
							extinct: ""
						* items.splice 0
					items.0 = newItem
					formatItems newItem.1
			if opts.deep and isElTarget
				if ul = target.querySelector \ul
					@extract ul.children,
						opts
						item.0
						item.1
			items.push item
		formatItems items
		unless parent
			items = items
				.flat Infinity
				.map ~> \\n + it.tab + it.text + it.extinct
				.join ""
		items

	doCombo: (combo, target, sel, event, args) !->
		doCombo = (combo2 = combo, target2 = target, sel2 = sel, args2 = args) !~>
			@doCombo combo2, target2, sel2, event, args2
		switch
		| sel
			switch
			| combo is \Slash
				@data = sel.replace @regexes.startsPrefixes, ""
				@data = @upperFirst @data
				@data = " # #@data"
				@copy @data
				@emptySel!
		| target
			switch
			| target.localName is \img
				captions =
					"RMB": " # %"
					"Shift+RMB": " | %"
					"F+RMB": " # % ; fossil"
					"R+RMB": " # % ; restoration"
					"C+RMB": " # % ; reconstruction"
					"E+RMB": " # % ; exhibit"
					"D+RMB": " # % ; drawing"
					"H+RMB": " # % ; holotype"
					"S+RMB": " # % ; skull"
					"K+RMB": " # % ; skeleton"
					"J+RMB": " # % ; jaw"
					"M+RMB": " # % ; mandible"
					"L+RMB": " # % ; illustration"
					"P+RMB": " # % ; specimen"
					"Period+RMB": " # % ; ."
					"Semicolon+RMB": " ; % ; "
					"Q+RMB": " # % | ?"
					"W+RMB": " # ? | %"
				if caption = captions[combo]
					{src} = target
					if /\/\d+px-.+/.test src
						src = src
							.replace /\https:\/\/upload\.wikimedia\.org\/wikipedia\/(commons|en)\/thumb/ ""
							.replace /\/\d+px-.+$/ ""
					else if /-\d+px-.+/.test src
						src .= replace /-\d+px-/ \-220px-
					else
						src .= replace \https://upload.wikimedia.org/wikipedia/commons ""
					@data = caption.replace \% src
					@copy @data
					@mark target
				else
					switch combo
					| \Alt+RMB
						@copy target.src
						@mark target
					| \I+RMB
						image = target.src
						@mark target
						await @uploadImgur image, \URL
			| target.matches "a:not(.new)[href]"
				if combo is \RMB
					window.open target.href
			| td = target.closest ".infobox.biota td:nth-child(2), .infobox.taxobox td:nth-child(2)"
				if combo is \RMB
					rankName = td.previousElementSibling.innerText
						.replace \: ""
						.trim!
					rank = @findRank \prefixes (.startsRegex.test rankName)
					if rank
						tab = rank.tab
						@data = @extract td,
							tab: tab
						@copy @data
						@mark td
			| el = target.closest ".infobox.biota .binomial, .infobox.taxobox .binomial"
				if combo is \RMB
					@data = @extract el,
						tab: @ranks.species.tab
					@copy @data
					@mark el
			| target is target.closest ".infobox.biota, .infobox.taxobox" ?.querySelector \th
				if combo is \RMB
					@mark target
					doCombo \Slash,, target.innerText
			| el = target.closest "
			.infobox.biota li, .infobox.biota dd, .infobox.biota p, .infobox.biota td:only-child,
			.infobox.taxobox li, .infobox.taxobox dd, .infobox.taxobox p, .infobox.taxobox td:only-child"
				if combo is \RMB
					if tr = target.closest \tr ?.previousElementSibling
						rankName = tr.innerText
							.replace \Type ""
							.trim!
						rank = @findRank \prefixes (.startsRegex.test rankName)
						if rank
							tab = rank.tab
					switch el.localName
					| \li \dd
						el .= parentElement
						node = el.children
					| \p
						node = el.innerText
							.replace /\u2013.*/ ""
							.replace /\(but see text\)/ ""
					else
						node = el.innerText
							.trim!
							.split \\n 1 .0
							.trim!
					@data = @extract node,
						tab: tab
					@copy @data
					@mark el
			| target.localName is \p and t.wikispecies
				if combo is \RMB
					text = target.innerText.trim!split /\n+/ .[* - 1]trim!
					if rank = @findRank \prefixes (.startsRegex.test text)
						tab = rank.tab
					text = text
						.replace /^.+?:\s*/ ""
						.replace /\s+[-\u2013]\s+/g \\n
					@data = @extract text,
						tab: tab
					@copy @data
					@mark target
			| target.localName in [\li \dd]
				ul = target.parentElement
				switch combo
				| \RMB
					@data = @extract ul.children,
						deep: yes
					@copy @data
					@mark ul
				| \Alt+RMB \Shift+Alt+RMB
					@openLinksExtract ul.children, combo is \Shift+Alt+RMB
			| td = target.closest \td
				table = td.closest \table
				col = @tableCol td
				switch combo
				| \RMB
					data = @extract col
					@copy data
					@mark col
				| \Alt+RMB \Shift+Alt+RMB
					@openLinksExtract col, combo is \Shift+Alt+RMB
			| target.matches '#firstHeading, h1, b'
				if combo is \RMB
					@mark target
					doCombo \Slash,, target.innerText
		else
			switch combo
			| \C
				(@els.commons or @els.enLang)?click!
			| \D
				(@els.viLang or @els.enLang)?click!
			| \S
				(@els.species or @els.enLang)?click!
			| \E
				if @data.includes \*
					@data -= /\*/g
				else
					@data .= replace /(?!^)(?=\n|$)/g \*
				@copy @data
			| \O
				text = await navigator.clipboard.readText!
				location.href = "https://en.wikipedia.org/wiki/#text"
			| \Shift+O
				text = await navigator.clipboard.readText!
				window.open "https://en.wikipedia.org/wiki/#text"
			| \I+U
				if blob = await @readCopiedImgBlob!
					base64 = await @readAsBase64 blob
					await @uploadImgur base64, \base64
			| \I+A
				@getImgurAlbum!
			| \I+T
				@getImgurToken!
			| \W+P
				location.href = \https://en.wikipedia.org/wiki/Special:Preferences
			| \W+E
				location.href = document.querySelector '#ca-edit a' .href
			| \W+H
				location.href = document.querySelector '#ca-history a' .href
			| \W+M
				location.href = document.querySelector '#ca-move a' .href
		switch combo
		| \Backquote+RMB
			@isContextMenu = yes
		| \Z
			history.back!
		| \X
			history.forward!
		| \W
			@closeTab!

	view: ->
		m.fragment do
			if t.wikiPage
				m \._sideLeft._column._px5._py4,
					m \._col,
						m \#_toc._mt6
			m \._sideCenter._col,
				m \._notifies,
					@notifies.map (notify) ~>
						m \._notify m.trust notify.html
				m \._modals._row._center,
					@modals.map (modal) ~>
						m \._modal._column,
							style: @style do
								width: modal.width
							m \._row._middle._px3._pt3,
								m \._col._textTruncate._textBold modal.title
								m \button._modalClose,
									onclick: !~>
										modal.close!
									"\u2a09"
							m \._col._scroll._m3 modal.view modal
			if t.wikiPage
				m \._sideRight._column._px5._py4,
					if @summ
						if @summ is yes
							m \._mt5._textCenter "Đang tải..."
						else
							m \._scroll,
								m \h1._summTitle @summ.title
								m \._summBox._mt5._p3._border,
									m \img._summImg._block src: @summ.thumbnail?source
									m \._summExtract._mt3._mb-0._textJustify m.trust @summ.extract_html
					else
						m \._mt5._textCenter._textRed "Không có tiếng Việt"
					m \._row._center._top._mt3,
						if el = @els.commons
							m \a._col6._row._center._middle._textGreen,
								href: el.href
								m \img._mr2,
									src: \https://commons.wikimedia.org/static/favicon/commons.ico
									height: 24
								"Commons"

appEl = document.createElement \div
appEl.id = \_app
document.body.appendChild appEl
m.mount appEl, App
