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
				prefixes: [\Domain \Super-?kingdom \Vực "Siêu giới"]
			* name: \kingdom
				prefixes: [\Kingdom \Giới]
			* name: \subkingdom
				prefixes: [\Sub-?kingdom "Phân giới"]
			* name: \infrakingdom
				prefixes: [\Infra-?kingdom "Thứ giới"]
			* name: \superphylum
				prefixes: [\Super-?phylum \Super-?division "Liên ngành" "Siêu ngành"]
			* name: \phylum
				prefixes: [\Phylum \Division \Ngành]
				suffixes: [\ophyta \mycota]
			* name: \subphylum
				prefixes: [\Sub-?phylum \Sub-?division "Phân ngành"]
				suffixes: [\phytina \mycotina]
			* name: \infraphylum
				prefixes: [\Infra-?phylum \Infra-?division "Thứ ngành"]
			* name: \parvphylum
				prefixes: [\Parv-?phylum \Micro-?phylum "Tiểu ngành"]
			* name: \superclass
				prefixes: [\Super-?class "Liên lớp" "Siêu lớp"]
			* name: \class
				prefixes: [\Class \Lớp]
				suffixes: [\opsida \phyceae \mycetes]
			* name: \subclass
				prefixes: [\Sub-?class "Phân lớp"]
				suffixes: [\phycidae \mycetidae]
			* name: \infraclass
				prefixes: [\Infra-?class "Thứ lớp"]
			* name: \parvclass
				prefixes: [\Parv-?class "Tiểu lớp"]
			* name: \legion
				prefixes: [\Legion \Đoàn]
			* name: \supercohort
				prefixes: [\Super-?cohort "Liên đội"]
			* name: \cohort
				prefixes: [\Cohort \Đội]
			* name: \magnorder
				prefixes: [\Magn-?order "Tổng bộ" "Đại bộ"]
			* name: \superorder
				prefixes: [\Super-?order "Liên bộ" "Siêu bộ"]
				suffixes: [\anae]
			* name: \order
				prefixes: [\Order \Bộ]
				suffixes: [\iformes \ales]
			* name: \suborder
				prefixes: [\Sub-?order "Phân bộ"]
				suffixes: [\ineae]
			* name: \infraorder
				prefixes: [\Infra-?order "Thứ bộ"]
				suffixes: [\aria]
			* name: \parvorder
				prefixes: [\Parv-?order "Tiểu bộ"]
			* name: \superfamily
				prefixes: [\Super-?family "Liên họ" "Siêu họ"]
				suffixes: [\oidea \acea]
			* name: \family
				prefixes: [\Family \Họ]
				suffixes: [\idae \aceae]
			* name: \subfamily
				prefixes: [\Sub-?family "Phân họ"]
				suffixes: [\inae \oideae]
			* name: \supertribe
				prefixes: [\Super-?tribe "Liên tông"]
			* name: \tribe
				prefixes: [\Tribe \Tông]
				suffixes: [\ini \eae]
			* name: \subtribe
				prefixes: [\Sub-?tribe "Phân tông"]
				suffixes: [\ina]
			* name: \genus
				prefixes: [\Genus \Chi]
			* name: \subgenus
				prefixes: [\Sub-?genus "Phân chi"]
			* name: \section
				prefixes: [\Section \Mục]
			* name: \series
				prefixes: [\Series \Loạt]
			* name: \superspecies
				prefixes: [\Super-?species "Liên loài"]
			* name: \species
				prefixes: [\Species \Loài]
			* name: \subspecies
				prefixes: [\Sub-?species "Phân loài"]
			* name: \variety
				prefixes: [\Variety \Thứ]
			* name: \form
				prefixes: [\Form \Dạng]
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
			..startsPrefixes = ///^(#{..prefixesStr})[^\S\r\n]+///i
			..extinct = /\b(tuyệt chủng|extinct|fossil)\b|†/i
		@notifies = []
		@modals = []
		@selection = getSelection!
		@token = null
		@album = null
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
			if el = document.querySelector '#Notes,#References,#External_links,#Reference\\/External_Links, #Tham_khảo,#Liên_kết_ngoài'
				el .= parentElement
				do
					nextEl = el.nextElementSibling
					el.remove!
				while el = nextEl
			if @els.viLang
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

	class: (...clses) ->
		res = []
		for cls in clses
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
		if @combo and document.activeElement.localName not in <[input textarea select]>
			@combo = @modfCombo + @combo
			sel = (@selection + "")trim!
			@doCombo @combo, @target, sel, event, []
		@resetCombo!

	mark: (el) !->
		{x, y, width, height} = el.getBoundingClientRect!
		{borderRadius} = getComputedStyle el
		borderRadius = \4px if parseInt(borderRadius) < 4
		_mark.animate do
			* left: [x + \px, x - 3 + \px]
				top: [y + \px, y - 3 + \px]
				width: [width + \px, width + 6 + \px]
				height: [height + \px, height + 6 + \px]
				borderRadius: [borderRadius, borderRadius]
				background: [\#07d2 \#07d0]
				boxShadow: ['0 0 0 2px #07d' '0 0 0 2px #07d2']
			* duration: 150

	emptySel: !->
		@selection.removeAllRanges!

	copy: (text) ->
		navigator.clipboard.writeText text if text

	upperFirst: (text) ->
		text.charAt 0 .toUpperCase! + text.substring 1

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
			notify = @notify "Đang upload ảnh Imgur" -1
			formData = new FormData
				..append \image image
				..append \album @album
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
					{id} = res.data
					await @copy " # #id"
					notify.update "Đã upload ảnh Imgur: #id"
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
		targets = [targets] unless \length of targets
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
				if items.every (.0.extinct)
					for item in items
						item.0.extinct = ""
					if parent
						parent.extinct = \*
			items.sort (a, b) ~>
				a.0.extinct.length - b.0.extinct.length or
				(a.0.text is \?) - (b.0.text is \?)
		for target, i in targets
			text = target.innerText
				.split \\n 1 .0
				.trim!
			extinct = parent?extinct ? ""
			unless extinct
				if @regexes.extinct.test text
					extinct = \*
			tab = void
			if opts.tab?
				tab = opts.tab
			if links = target.querySelectorAll ":scope> i> a, :scope> a"
				for link in links
					innerText = link.innerText.trim!
					unless innerText is \† or link.closest \small
						text = innerText
						opts.link? target, link
			text = text
				.replace @regexes.extinct, ""
				.trim!
			if tab
				rank = @findRank (.tab is tab)
			else
				rank = @findRank \prefixes (.startsRegex.test text)
			text = text
				.replace @regexes.startsPrefixes, ""
				.replace /"(.+?)"/g \$1
				.replace /'(.+?)'/g \$1
			rank ?= @findRank \suffixes (.startsRegex.test text)
			tab = rank?tab ? ""
			notMatchTab ?= tab
			if rank
				switch
				| rank.lv is 35
					if matched = /^([A-Z][a-z]+|[A-Z]\.)\s([a-z-]{2,}|[a-z]\.)\s([a-z-]{2,})/
						text = matched.3
					else
						text = opts.notMatchText
				| rank.lv is 34
					if matched = /^([A-Z][a-z]+|[A-Z]\.)\s([a-z-]{2,})/ is text
						text = matched.2
					else
						text = opts.notMatchText
				| /\b(incertae sedis|uncertain)\b/i is text
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
			if opts.deep
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
				data = sel.replace @regexes.startsPrefixes, ""
				data = @upperFirst data
				data = " # #data"
				@copy data
				@emptySel!
		| target
			switch
			| target.localName is \img
				switch combo
				| \RMB
					{src} = target
					if /\/\d+px-.+/.test src
						src = src
							.replace \https://upload.wikimedia.org/wikipedia/commons/thumb ""
							.replace /\/\d+px-.+$/ ""
					else if /-\d+px-.+/.test src
						src .= replace /-\d+px-/ \-220px-
					else
						src .= replace \https://upload.wikimedia.org/wikipedia/commons ""
					@copy " # #src"
					@mark target
				| \M+RMB
					image = target.src
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
						data = @extract td,
							tab: tab
						@copy data
						@mark td
			| el = target.closest ".infobox.biota .binomial, .infobox.taxobox .binomial"
				if combo is \RMB
					data = @extract el,
						tab: @ranks.species.tab
					@copy data
					@mark el
			| p = target.closest ".infobox.biota td p, .infobox.taxobox td p"
				as = p.querySelectorAll "i> a"
				data = @extract as
				@copy data
				@mark p
			| target.localName is \li
				switch combo
				| \RMB
					ul = target.parentElement
					data = @extract ul.children,
						deep: yes
					@copy data
					@mark ul
				| \Alt+RMB \Shift+Alt+RMB
					ul = target.parentElement
					count = 0
					@extract ul.children,
						link: (target, link) !~>
							unless target.dataset.openedLi
								if count++ < 10
									target.dataset.openedLi = 1
									if link
										link.dataset.openedA = 1
										if combo is \Alt+RMB
											window.open link.href
					if count
						if combo is \Alt+RMB
							chrome.runtime.sendMessage \openTabs
					else
						@notify "Đã mở hết link"
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
			| \I+U
				if blob = await @readCopiedImgBlob!
					base64 = await @readAsBase64 blob
					await @uploadImgur base64, \base64
			| \I+A
				@getImgurAlbum!
			| \I+T
				@getImgurToken!
		switch combo
		| \Z
			history.back!
		| \X
			history.forward!
		| \W
			@closeTab!

	view: ->
		m.fragment do
			if t.wikiPage
				m \._sideLeft,
					m \._col._px5._py4,
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
				m \._sideRight,
					m \._col._px5._py4,
						if @summ
							m.fragment do
								m \h1._summTitle @summ.title
								m \._summBox._mt5._p3._border,
									m \img._summImg._block src: @summ.thumbnail?source
									m \._summExtract._mt3._mb-0._textJustify m.trust @summ.extract_html
						else
							m \._mt5._textCenter._textRed "Không có tiếng Việt"
			m \#_mark

appEl = document.createElement \div
appEl.id = \_app
document.body.appendChild appEl
m.mount appEl, App
