App =
	oninit: !->
		for k, val of @
			@[k] = val.bind @ if typeof val is \function
		@cfg = null
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
				combo: \1+Backquote
			* name: \kingdom
				prefixes:
					\kingdom
					\kingdoms
					\regnum
					\regna
					\giới
				combo: \1
			* name: \subkingdom
				prefixes:
					\sub-?kingdom
					\sub-?kingdoms
					\sub-?regnum
					\sub-?regna
					"phân giới"
				combo: \1+2
			* name: \infrakingdom
				prefixes:
					\infra-?kingdom
					\infra-?kingdoms
					\infra-?regnum
					\infra-?regna
					"thứ giới"
				combo: \1+3
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
				combo: \2+1
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
				combo: \2
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
				combo: \2+3
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
				combo: \2+4
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
				combo: \2+5
			* name: \superclass
				prefixes:
					\super-?class
					\super-?classes
					\super-?classis
					"liên lớp"
					"siêu lớp"
				combo: \3+2
			* name: \class
				prefixes:
					\class
					\classes
					\classis
					\lớp
				suffixes: <[opsida phyceae mycetes]>
				combo: \3
			* name: \subclass
				prefixes:
					\sub-?class
					\sub-?classes
					\sub-?classis
					"phân lớp"
				suffixes: <[phycidae mycetidae]>
				combo: \3+4
			* name: \infraclass
				prefixes:
					\infra-?class
					\infra-?classes
					\infra-?classis
					"thứ lớp"
					"phân thứ lớp"
				combo: \3+5
			* name: \parvclass
				prefixes:
					\parv-?class
					\parv-?classes
					\parv-?classis
					"tiểu lớp"
				combo: \3+6
			* name: \legion
				prefixes:
					\legion
					\legions
					\đoàn
				combo: \4+2
			* name: \supercohort
				prefixes:
					\super-?cohort
					\super-?cohorts
					\super-?cohors
					\super-?cohortes
					"liên đội"
				combo: \4+3
			* name: \cohort
				prefixes:
					\cohort
					\cohorts
					\cohors
					\cohortes
					\đội
				combo: \4
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
				combo: \5+3
			* name: \superorder
				prefixes:
					\super-?order
					\super-?orders
					\super-?ordo
					\super-?ordines
					"liên bộ"
					"siêu bộ"
				suffixes: <[anae]>
				combo: \5+4
			* name: \order
				prefixes:
					\order
					\orders
					\ordo
					\ordines
					\bộ
				suffixes: <[iformes ales]>
				combo: \5
			* name: \suborder
				prefixes:
					\sub-?order
					\sub-?orders
					\sub-?ordo
					\sub-?ordines
					"phân bộ"
				suffixes: <[ineae]>
				combo: \5+6
			* name: \infraorder
				prefixes:
					\infra-?order
					\infra-?orders
					\infra-?ordo
					\infra-?ordines
					"thứ bộ"
				suffixes: <[aria]>
				combo: \5+7
			* name: \parvorder
				prefixes:
					\parv-?order
					\parv-?orders
					\parv-?ordo
					\parv-?ordines
					"tiểu bộ"
				combo: \5+8
			* name: \superfamily
				prefixes:
					\super-?family
					\super-?families
					\super-?familia
					\super-?familiae
					"liên họ"
					"siêu họ"
				suffixes: <[oidea acea]>
				combo: \6+5
			* name: \family
				prefixes:
					\family
					\families
					\familia
					\familiae
					\họ
				suffixes: <[idae aceae]>
				combo: \6
			* name: \subfamily
				prefixes:
					\sub-?family
					\sub-?families
					\sub-?familia
					\sub-?familiae
					"phân họ"
				suffixes: <[inae oideae]>
				combo: \6+7
			* name: \supertribe
				prefixes:
					\super-?tribe
					\super-?tribes
					\super-?tribus
					"liên tông"
				combo: \7+6
			* name: \tribe
				prefixes:
					\tribe
					\tribes
					\tribus
					\tông
				suffixes: <[ini eae]>
				combo: \7
			* name: \subtribe
				prefixes:
					\sub-?tribe
					\sub-?tribes
					\sub-?tribus
					"phân tông"
				combo: \7+8
			* name: \genus
				prefixes:
					\genus
					\genera
					\chi
				combo: \8
			* name: \subgenus
				prefixes:
					\sub-?genus
					\sub-?genera
					"phân chi"
				combo: \8+9
			* name: \section
				prefixes:
					\section
					\sections
					\sectio
					\sectiones
					\mục
				combo: \8+0
			* name: \series
				prefixes:
					\series
					\loạt
				combo: \8+Minus
			* name: \superspecies
				prefixes:
					\super-?species
					\complex
					"liên loài"
				combo: \9+8
			* name: \species
				prefixes:
					\species
					\loài
				combo: \9
			* name: \subspecies
				prefixes:
					\sub-?species
					"phân loài"
				combo: \9+0
			* name: \variety
				prefixes:
					\variety
					\varieties
					\varietas
					\thứ
				combo: \9+Minus
			* name: \form
				prefixes:
					\form
					\forms
					\forma
					\dạng
				combo: \9+Equal
		@ranks.prefixes = []
		@ranks.suffixes = []
		for rank, i in @ranks
			rank.lv = i
			rank.tab = \\t * i
			for text in rank.prefixes
				prefix =
					text: text
					regex: //#text//i
					startsRegex: //^#text[ \xa0:]+//i
					rank: rank
				@ranks.prefixes.push prefix
			if rank.suffixes
				for text in rank.suffixes
					suffix =
						text: text
						regex: //[A-Z][a-z]*#text//
						startsRegex: //^[A-Z][a-z]*#text(?=[^a-z\-]|$)//
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
			..prefixes = //(#{..prefixesStr})$//i
			..startsPrefixes = //^(#{..prefixesStr})[ \xa0:]+//i
			..extinct = /\b(tuyệt chủng|extinct|fossil)\b|†/i
			..incSedis = /\b(incertae sedis|inc\. sedis|uncertain)\b/i
		@data = null
		@notifies = []
		@modals = []
		@selection = getSelection!
		@token = null
		@album = null
		@canMiddleClick = yes
		@canContextMenu = no
		@comboRanks = []
		@resetCombo!
		@els = {}
		@imgurEditRatio = 0
		@imgurEditRatioOrg = 0
		@imgurEditRatio1Img = (320 / 240)toFixed 3
		@imgurEditRatio2Img = (280 / 240)toFixed 3
		window.addEventListener \mousedown @onmousedown, yes
		window.addEventListener \mouseup @onmouseup, yes
		window.addEventListener \auxclick @onauxclick, yes
		window.addEventListener \contextmenu @oncontextmenu, yes
		window.addEventListener \keydown @onkeydown, yes
		window.addEventListener \keyup @onkeyup, yes
		window.addEventListener \visibilitychange @onvisibilitychange, yes
		chrome.storage.local.get do
			<[cfg token tokenTime album]>
			({@cfg = {}, @token, tokenTime, @album}) !~>
				unless t.imgur
					unless @token and tokenTime + 6048e5 > Date.now!
						await @getImgurToken!
					unless @album
						until await @getImgurAlbum! =>
		switch
		| t.wiki
			@summ = null
			@els
				..viLang = document.querySelector ".interlanguage-link-target[lang=vi]"
				..enLang = document.querySelector ".interlanguage-link-target[lang=en]"
				..esLang = document.querySelector ".interlanguage-link-target[lang=es]"
				..frLang = document.querySelector ".interlanguage-link-target[lang=fr]"
				..commons = document.querySelector ".wb-otherproject-commons> a"
				..species = document.querySelector ".wb-otherproject-species> a"
				..infoboxImg = document.querySelector ".infobox.biota a.image> img, .infobox.taxobox a.image> img"
				..infoboxLinkImg = ..infoboxImg?parentElement
			if el = document.querySelector '
			#Notes,#References,#External_links,#Reference\\/External_Links,#Sources,
			#Chú_thích,#Tham_khảo,#Liên_kết_ngoài'
				el .= parentElement
				do
					nextEl = el.nextElementSibling
					el.remove!
				while el = nextEl
			if @els.commons
				@prerender that.href
			if @els.viLang
				@summ = yes
				q = that.href.split \/ .[* - 1]
				@summ = await (await fetch "https://vi.wikipedia.org/api/rest_v1/page/summary/#q")json!
				m.redraw!
		| t.imgur
			switch
			| t.imgurEdit
				widthEl = document.getElementById \width
				heightEl = document.getElementById \height
				sizeEl = document.getElementById \crop-dimensions
				@imgurEditRatio = @imgurEditRatioOrg = +(widthEl.value / heightEl.value)toFixed 3
				window.addEventListener \mousemove (event) !~>
					if event.which is 1
						[, w, h] = /^(\d+)x(\d+)$/exec sizeEl.innerText
						@imgurEditRatio = +(w / h)toFixed 3
						m.redraw!
				for el in [widthEl, heightEl]
					el.addEventListener \change (event) !~>
						@imgurEditRatio = @imgurEditRatioOrg = +(widthEl.value / heightEl.value)toFixed 3
						m.redraw!
			| t.imgurView
				usp = new URLSearchParams location.search
				if usp.get \_taxonDelete
					timer = setInterval !~>
						if el = document.querySelector \.image-delete
							el.click!
							clearInterval timer
							setTimeout !~>
								el = document.querySelector \.DeleteImageDialog-confirm--accountRemove
								el.click!
								timer2 = setInterval !~>
									unless document.querySelector \.image-delete
										@closeTab!
								, 500
							, 100
					, 500
			else
				if location.search is \?state=taxon
					@token = /access_token=([a-z\d]+)/exec location.hash .1
					chrome.storage.local.set do
						token: @token
						tokenTime: Date.now!
						@closeTab
		| t.inaturalist
			switch
			| t.inaturalistSearch
				els = document.querySelectorAll ".taxon_list_taxon> .noimg"
				for el in els
					el.remove!
		| t.biolib
			setTimeout !~>
				document.activeElement.blur!
			, 10

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

	onauxclick: (event) !->
		unless @canMiddleClick
			event.preventDefault!
			@canMiddleClick = yes

	oncontextmenu: (event) !->
		if @canContextMenu
			@canContextMenu = no
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
			combo = @modfCombo + @combo
			switch combo
			| \Ctrl+Shift+S
				@resetCombo!

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
			for {x, y, width, height} in rects
				markEl = document.createElement \div
				markEl.className = \_mark
				document.body.appendChild markEl
				anim = markEl.animate do
					* left: [x + \px, x - 3 + \px]
						top: [y + \px, y - 3 + \px]
						width: [width + \px, width + 6 + \px]
						height: [height + \px, height + 6 + \px]
						background: [\#07d2 \#07d0]
						boxShadow: ['0 0 0 2px #07d' '0 0 0 2px #07d2']
					* duration: 150
				anim.onfinish = markEl~remove

	emptySel: !->
		@selection.removeAllRanges!

	copy: (text) ->
		if text?
			if navigator.clipboard
				that.writeText text
			else
				el = document.createElement \textarea
				el.className = \_copy
				el.value = text
				el.onblur = el.focus.bind el
				document.body.appendChild el
				document.activeElement.blur!
				el.select!
				document.execCommand \copy
				el.remove!

	openLinksExtract: (targets, noOpen) !->
		urls = []
		@data = @extract targets,
			link: (target, link) !~>
				return if noOpen and urls.length >= 10
				unless target.dataset.openedLi
					target.dataset.openedLi = 1
					if link
						unless link.classList.contains \new
							link.dataset.openedA = 1
							urls.push link.href
		if urls.length
			unless noOpen
				@copy @data
				chrome.runtime.sendMessage do
					act: \openUrls
					urls: urls
		else
			@notify "Đã mở hết link"

	prerender: (url) !->
		link = document.createElement \link
		link.rel = \prerender
		link.href = url
		document.head.appendChild link

	setCfg: (prop, val, cb) !->
		@cfg[prop] = val
		chrome.storage.local.set {@cfg}, cb

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
		if item
			[type] = item.types.filter (.startsWith \image/)
			item.getType type if type

	uploadImgur: ({image, type = \URL, isOpenNewTab, isFemale}) ->
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
					notify.update "Đã upload ảnh Imgur: #id"
					sep = isFemale and \| or \#
					await @copy " #sep -#id"
					if type is \URL
						url = "https://imgur.com/edit?deletehash=#deletehash&album_id=#album&_taxonId=#id"
						if isOpenNewTab
							window.open url
						else
							location.href = url
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
						m \._row6._gap2,
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
									@modalCreateAlbum!
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
								albumId = res.data.id
								@notify "Đã tạo album Imgur: #albumId"
								modal.close res.data
								@getImgurAlbum albumId
							else
								@notify "Tạo album Imgur thất bại"
					m \p,
						m \div "Tên album:"
						m \input._input._mt2,
							name: \title
							required: yes
							autocomplete: \off
						m \._textRight._mt2,
							m \button._button \OK
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

	getImgurAlbum: (albumId) ->
		new Promise (resolve) !~>
			album = albumId or await @modalGetAlbums!
			if album
				chrome.storage.local.set {album} !~>
					@album = album
					@notify "Đã đặt album Imgur: #@album"
					resolve album
			else resolve!

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

	extract: (targets, opts = {}, parent, items = [], index = 0) ->
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
			ranks: @comboRanks
			...opts
		}
		notMatchTab = void
		formatItems = (items) !~>
			if items.length
				if parent
					if items.every (.0.extinct)
						for item in items
							item.0.extinct = ""
						parent.extinct = \*
			uniqItems = []
			uniqTexts = []
			for item in items
				itemText = item.0.text - \*
				if itemText is \? or not uniqTexts.includes itemText
					uniqItems.push item
					uniqTexts.push itemText
			items.splice 0 Infinity, ...uniqItems
			items.sort (a, b) ~>
				a.0.extinct.length - b.0.extinct.length or
				(a.0.text is \?) - (b.0.text is \?) or
				(a.0.text is \_) - (b.0.text is \_)
		for target, i in targets
			isElTarget = target instanceof Element
			text = void
			if isElTarget
				if target.childNodes.length is 1 and target.firstElementChild?matches "ul, ol, dl"
					@extract target.firstChild.children,
						opts
						parent
						items
						index + 1
					continue
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
			if isElTarget
				links = [...target.querySelectorAll ":scope> i> a, :scope> b> a, :scope> a"]
				if links.length
					for link in links
						innerText = link.innerText.trim!
						switch
						| innerText is \†
							link.dataset.excl = 1
						# | @regexes.prefixes.test innerText
						# 	link.dataset.excl = 1
						else
							opts.link? target, link
				textEl = null
				unless textEl
					if el = target.querySelector ':scope> a> .toctext'
						if el.innerText.trim!0 is /[A-Z]/
							textEl = el
				unless textEl
					if el = target.querySelector ':scope> a:not([data-excl])'
						if el.nextSibling?textContent.0 is \:
							textEl = el
				unless textEl
					if el = target.querySelector ':scope> i:first-child'
						if el.innerText.trim!0 is /[A-Z]/
							textEl = el
				unless textEl
					if el = target.querySelector ':scope> i> a:not([data-excl])'
						if el.innerText.trim!0 is /[A-Z]/
							textEl = el
				unless textEl
					if el = target.querySelector ':scope> b> a:not([data-excl])'
						if el.innerText.trim!0 is /[A-Z]/
							textEl = el
				unless textEl
					if el = target.querySelector ':scope> i'
						if el.innerText.trim!
							textEl = el
				unless textEl
					if el = target.querySelector ':scope> a:not([data-excl])'
						textEl = el
				if textEl
					if textEl.localName is \i and el = textEl.nextSibling
						if el.wholeText is /^( subsp\. | sp\. )/
							textEl = null
				if textEl
					text = textEl.innerText.trim!
			text ?= targetText
			text = text
				.replace @regexes.startsPrefixes, ""
				.replace /["'?]|=.+$/g ""
				.replace /^([A-Z][a-z]+) \([A-Z][a-z]+\)( [a-z]{2,})$/ \$1$2
				.replace /[()]/g ""
			if text is /^[A-Z][a-z]+ \(([A-Z][a-z]+)\) [a-z]{2,}$/
				subgenera[that.1] = yes
			if /\ cf\. |(?<!sub)sp\. | sp\. (?![a-z])/ is text
				continue
			tab = void
			rank = opts.ranks[index]
			rank ?= @findRank \prefixes (.startsRegex.test targetText)
			rank ?= @findRank \suffixes (.startsRegex.test text)
			tab = rank?tab ? ""
			notMatchTab ?= tab
			subspeciesRegex = //
				^[A-Z]([a-z]+|\.)?\s
				(\([a-z-]{2,}\)|[a-z-]{2,}|[a-z]\.)\s
				(?:subsp\.\s)?
				([a-z-]{2,})
			//
			subspeciesNameRegex = /^[a-z]{2,}$/
			speciesRegex = /^[A-Z]([a-z]+|\.)\s([A-Z]([a-z]+|\.)\s)?([a-z-]{2,})/
			otherRankRegex = /^([A-Z][a-z]+)/
			if rank
				switch
				| rank.lv is 35
					if matched = subspeciesRegex.exec text
						text = matched.3
					else if matched = subspeciesNameRegex.exec text
						text = matched.0
					else
						text = opts.notMatchText
				| rank.lv is 34
					if matched = speciesRegex.exec text
						text = matched.4
					else
						text = opts.notMatchText
				| @regexes.incSedis.test text
					text = \?
				| matched = otherRankRegex.exec text
					text = matched.1
				else
					text = opts.notMatchText
			else
				switch
				| @regexes.incSedis.test text
					text = \?
					tab = notMatchTab
				| matched = subspeciesRegex.exec text
					text = matched.3
					tab = @ranks.subspecies.tab
				| matched = speciesRegex.exec text
					text = matched.4
					tab = @ranks.species.tab
				| matched = otherRankRegex.exec text
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
							text: \_
							extinct: ""
						* items.splice 0
					items.0 = newItem
					formatItems newItem.1
			if opts.deep and isElTarget
				if ul = target.querySelector "ul, ol, dl"
					@extract ul.children,
						opts
						item.0
						item.1
						index + 1
			items.push item
		formatItems items
		unless parent
			items = items
				.flat Infinity
				.map ~> \\n + it.tab + it.text + it.extinct
				.join ""
			@comboRanks = []
			m.redraw!
		items

	doCombo: (combo, target, sel, event, args) !->
		doCombo = (combo2 = combo, target2 = target, sel2 = sel, args2 = args) !~>
			@doCombo combo2, target2, sel2, event, args2
		comboIncludes = (...keys) ~>
			//(^|\+)(#{keys.join \|})(\+|$)//test combo
		if rank = @findRank (.combo is combo)
			@comboRanks.push rank
		else if combo is \0
			@comboRanks = []
		if target
			switch
			| combo is \Backquote+RMB
				@canContextMenu = yes
			| sel and comboIncludes \RMB \Slash
				@data = sel.replace @regexes.startsPrefixes, ""
				@data = @upperFirst @data
				@data = " # #@data"
				@copy @data
				@emptySel!
			| target.localName is \img or (t.inaturalist and target.matches "a.photo-container, a.photo")
				unless t.imgurEdit
					captions =
						"RMB": " # %"
						"Shift+RMB": " | %"
						"Alt+RMB": " ; % ; "
						"F+RMB": " # % ; fossil"
						"R+RMB": " # % ; restoration"
						"C+RMB": " # % ; reconstruction"
						"E+RMB": " # % ; exhibit"
						"D+RMB": " # % ; drawing"
						"H+RMB": " # % ; holotype"
						"P+RMB": " # % ; paratype"
						"U+RMB": " # % ; skull"
						"T+RMB": " # % ; skeleton"
						"J+RMB": " # % ; jaw"
						"M+RMB": " # % ; mandible"
						"L+RMB": " # % ; illustration"
						"S+RMB": " # % ; specimen"
						"Q+RMB": " # % | ?"
						"W+RMB": " # ? | %"
					if caption = captions[combo]
						{src} = target
						data = ""
						if src.includes \//upload.wikimedia.org/
							data = match src
								| /\/\d+px-.+/
									src
										.replace /\https:\/\/upload\.wikimedia\.org\/wikipedia\/(commons|en)\/thumb\/./ ""
										.replace /\/\d+px-.+$/ ""
								| /-\d+px-.+/
									src.replace /-\d+px-/ \-220px-
								else
									src.replace /https:\/\/upload\.wikimedia\.org\/wikipedia\/(commons|en)\/./ ""
							if src.includes \/wikipedia/en/
								data = \/ + data
						else if matched = src is /\/\/(static\.inaturalist\.org|inaturalist-open-data\.s3\.amazonaws\.com)\//
							isAmazonAws = matched.1 is \inaturalist-open-data.s3.amazonaws.com and \: or ""
							[, name, ext] = /\/photos\/(\d+)\/[a-z]+\.([a-zA-Z]*)/exec src
							type = {jpg: "" jpeg: \e png: \p JPG: \J JPEG: \E PNG: \P "": \u}[ext]
							data = ":#isAmazonAws#name#type"
						else if src.includes \//live.staticflickr.com/
							name = /^https:\/\/live\.staticflickr\.com\/(\d+\/\d+_[\da-f]+)_[a-z]\.jpg+/exec src .1
							data = "@#name"
						else if src.includes \//www.biolib.cz/
							name = /(\d+)\.jpg$/exec src .1
							data = "%#name"
						else if src.includes \//bugguide.net/
							name = /([A-Z\d]+)\.jpg$/exec src .1
							if src.includes \/raw/
								name += \r
							data = "~#name"
						else if src is /fishbase\.[a-z]+\//
							isUpload = src is /uploadphoto/i and \^ or ""
							regex =
								if src.includes \workimagethumb
									/%2fuploadphoto%2fuploads%2f(.+)\.[a-z]+&w=\d+$/i
								else /(?:tn_)?([^/]+)\.[a-z]+$/i
							name = regex.exec src .1 .toLowerCase!
							data = "^#isUpload#name"
						else if src.includes \//cdn.download.ams.birds.cornell.edu/
							if name = /\/asset\/(\d+)1(\/|$)/exec src ?.1
								data = "+#name"
							else
								@notify "Không thể lấy dữ liệu hình ảnh"
						else if src.includes \//i.imgur.com/
							name = /https:\/\/i\.imgur\.com\/([A-Za-z\d]{7})/exec src .1
							data = "-#name"
						@data = caption.replace \% data
						@copy @data
						@mark target
					else
						switch combo
						| \I+RMB \I+MMB \Shift+I+RMB \Shift+I+MMB
							@canMiddleClick = no
							image = target.src
							isOpenNewTab = comboIncludes \MMB or (t.inaturalist and target.classList.contains \photo)
							@mark target
							await @uploadImgur do
								image: image
								type: \URL
								isOpenNewTab: isOpenNewTab
								isFemale: comboIncludes \Shift
			| target.matches "a:not(.new)[href]" and combo is \RMB
				if combo is \RMB
					window.open target.href
			| td = target.closest ".infobox.biota td:nth-child(2), .infobox.taxobox td:nth-child(2)"
				if combo in [\RMB \LMB]
					rankName = td.previousElementSibling.innerText
						.replace \: ""
						.trim!
					rank = @findRank \prefixes (.regex.test rankName)
					if rank
						@data = @extract td,
							ranks: [rank]
						@copy @data
						@mark td
			| el = target.closest ".infobox.biota .binomial, .infobox.taxobox .binomial"
				if combo in [\RMB \LMB]
					@data = @extract el,
						ranks: [@ranks.species]
					@copy @data
					@mark el
			| el = target.closest "dl> dt:only-child"
				if combo in [\RMB \LMB]
					@data = @extract el
					@copy @data
					@mark el
			| target is target.closest ".infobox.biota, .infobox.taxobox" ?.querySelector \th
				if combo in [\RMB \LMB]
					@mark target
					doCombo \Slash,, target.innerText
			| target.localName in [\li \dd]
				ul = target.parentElement
				switch combo
				| \RMB \LMB
					@data = @extract ul.children,
						deep: yes
					await @copy @data
					@mark ul
					if @cfg.copyExtractDeepAndOpenLinkExtract
						@openLinksExtract ul.children
				| \Alt+RMB \Shift+Alt+RMB \Alt+LMB \Shift+Alt+LMB
					@openLinksExtract ul.children, combo in [\Shift+Alt+RMB \Shift+Alt+LMB]
				| \Backspace+RMB \Backspace+LMB
					subUls = ul.querySelectorAll \ul
					for subUl in subUls
						subUl.remove!
			| target.closest \.CategoryTreeItem
				wrapper = target.closest \#mw-subcategories
				switch combo
				| \Alt+RMB \Shift+Alt+RMB \Alt+LMB \Shift+Alt+LMB
					links = wrapper.querySelectorAll \.CategoryTreeItem
					@openLinksExtract links, combo in [\Shift+Alt+RMB \Shift+Alt+LMB]
			| el = target.closest "
			.infobox.biota p, .infobox.biota td:only-child,
			.infobox.taxobox p, .infobox.taxobox td:only-child"
				if combo in [\RMB \LMB]
					if tr = target.closest \tr ?.previousElementSibling
						rankName = tr.innerText
							.replace \Type ""
							.trim!
						rank = @findRank \prefixes (.regex.test rankName)
					switch el.localName
					| \p
						text = el.innerText
							.replace /\u2013.*/ ""
							.replace /\(but see text\)/ ""
					else
						text = el.innerText
							.trim!
							.split \\n 1 .0
							.trim!
					@data = @extract text,
						ranks: [rank]
					@copy @data
					@mark el
			| t.wikispecies and target.localName is \p
				if combo in [\RMB \LMB]
					text = target.innerText.trim!split /\n+/ .[* - 1]trim!
					rank = @findRank \prefixes (.startsRegex.test text)
					text = text
						.replace /^.+?:\s*/ ""
						.replace /\s+[-\u2013]\s+/g \\n
					@data = @extract text,
						ranks: [rank]
					@copy @data
					@mark target
			| t.wiki and td = target.closest \td
				table = td.closest \table
				col = @tableCol td
				switch combo
				| \RMB \LMB
					data = @extract col
					await @copy data
					@mark col
					if @cfg.copyExtractDeepAndOpenLinkExtract
						@openLinksExtract col
				| \Alt+RMB \Shift+Alt+RMB \Alt+LMB \Shift+Alt+LMB
					@openLinksExtract col, combo in [\Shift+Alt+RMB \Shift+Alt+LMB]
			| target.matches '#firstHeading, h1, b'
				if combo in [\RMB \LMB]
					@mark target
					doCombo \Slash,, target.innerText
		else
			switch combo
			| \C
				(@els.commons or @els.enLang)?click!
			| \D
				if t.inaturalist
					document.querySelector \.next_page ?.click!
				else
					(@els.enLang or @els.viLang)?click!
			| \D+V
				(@els.viLang or @els.enLang)?click!
			| \D+E
				(@els.esLang or @els.enLang)?click!
			| \D+F
				(@els.frLang or @els.enLang)?click!
			| \S
				if t.imgurEdit
					document.getElementById \save .click!
				else
					(@els.species or @els.enLang)?click!
			| \E
				if @data.includes \*
					@data -= /\*/g
				else
					@data .= replace /(?!^)(?=\n|$)/g \*
				@copy @data
			| \V
				if t.inaturalist
					if el = document.querySelector "[name=taxon_name]"
						text = await navigator.clipboard.readText!
						el.select!
						el.value = text
			| \O \Shift+O
				text = await navigator.clipboard.readText!
				url = "https://en.wikipedia.org/wiki/#text"
				if combo is \O
					location.href = url
				else
					window.open url
			| \G \G+I \G+E \G+H \G+S
				switch
				| t.google
					q = document.querySelector \#REsRA .value
				| t.fishbase
					q = document.querySelector ".ptitle a" .textContent
				| t.inaturalist
					q = document.querySelector \#q .value
				| t.seriouslyfish
					q = /[^/]+$/exec location.pathname .0
						.replace /^./ (.toUpperCase!)
						.replace /-/g " "
				else
					document.querySelector \#firstHeading .innerText .replace \Category: ""
				switch combo
				| \G
					location.href = "https://google.com/search?tbm=isch&q=#q"
				| \G+I
					location.href = "https://inaturalist.org/taxa/search?view=list&q=#q"
				| \G+E
					data = await (await fetch "https://api.ebird.org/v2/ref/taxon/find?key=jfekjedvescr&q=#q")json!
					item = data.find (.name.includes name) or data.0
					if item
						location.href = "https://ebird.org/species/#{item.code}"
					else
						@notify "Không tìm thấy trên ebird.org"
				| \G+H
					[genus, species] = q.split " "
					location.href = "https://fishbase.us/photos/ThumbnailsSummary.php?Genus=#genus&Species=#species"
				| \G+S
					q = q.toLowerCase!replace /\ /g \-
					location.href = "https://www.seriouslyfish.com/species/#q"
			| \I+U
				if blob = await @readCopiedImgBlob!
					base64 = await @readAsBase64 blob
					await @uploadImgur do
						image: base64
						type: \base64
			| \I+A
				@getImgurAlbum!
			| \I+T
				@getImgurToken!
			| \I+L
				{data} = await (await fetch "https://api.imgur.com/3/credits",
					headers:
						"Authorization": "Bearer #@token"
				)json!
				now = Math.floor Date.now! / 1000
				@modal "Giới hạn Imgur", 340, (modal) ~>
					m \._row._wrap,
						m \._col9._mb2 "Giới hạn người dùng"
						m \._col3._mb2 data.UserLimit
						m \._col9._mb2 "Giới hạn người dùng còn lại"
						m \._col3._mb2 data.UserRemaining
						m \._col9._mb2 "Thời gian reset giới hạn người dùng"
						m \._col3._mb2 Math.floor((data.UserReset - now) / 60) + " phút"
						m \._col9._mb2 "Giới hạn ứng dụng"
						m \._col3._mb2 data.ClientLimit
						m \._col9._mb2 "Giới hạn ứng dụng còn lại"
						m \._col3._mb2 data.ClientRemaining
			| \W+O
				location.href = \https://en.wikipedia.org/wiki/Special:Preferences
			| \W+E
				location.href = document.querySelector '#ca-ve-edit a' .href
			| \W+H
				location.href = document.querySelector '#ca-history a' .href
			| \W+M
				location.href = document.querySelector '#ca-move a' .href
			| \A
				cfgs =
					c: \copyExtractDeepAndOpenLinkExtract
				text = "Đặt cấu hình (key + val, val sẽ được convert sang số nếu có thể, vd: c1):"
				for k, val of cfgs
					text += "\n(#k): #val: #{@cfg[val]}"
				if text = prompt text
					key = text.0
					prop = cfgs[key]
					if prop
						if val = text.substring 1
							val = +val if isFinite val
						else val = void
						@setCfg prop, val, !~>
							@notify "#{cfgs[key]}: #val"
					else
						@notify "Key '#key' không hợp lệ"
			| \Delete
				if t.imgurEdit
					usp = new URLSearchParams location.search
					id = usp.get \_taxonId
					location.href = "https://imgur.com/#id?_taxonDelete=1"
			| \ArrowLeft
				if el = document.querySelector \.nav-button
					el.click!
			| \ArrowRight
				if el = document.querySelector \.nav-button.next
					el.click!
			| \Z
				history.back!
			| \X
				history.forward!
			| \W
				@closeTab!
		m.redraw!

	view: ->
		m.fragment do
			if t.wikiPage
				m \._sideLeft,
					m \._column._px5._py4,
						m \._col._scroll,
							m \#_toc._mt6
						m \._col0._mt3,
							@comboRanks.map (rank) ~>
								m \div,
									style: @style do
										marginLeft: rank.lv * 4
									rank.tab + rank.name
			m \._sideCenter._col,
				m \._notifies,
					@notifies.map (notify) ~>
						m \._notify m.trust notify.html
				m \._modals._row._center,
					@modals.map (modal, i) ~>
						m \._modal._column,
							key: modal
							style: @style do
								width: modal.width
								marginTop: i * 32
							onbeforeremove: (vnode) ~>
								new Promise (resolve) !~>
									vnode.dom.classList.add \_fadeOut95
									setTimeout resolve, 1000
							m \._row._middle._pl4._pr3._pt3,
								m \._col._textTruncate._textBold,
									modal.title
								m \button._modalClose,
									onclick: !~>
										modal.close!
									"\u2a09"
							m \._col._scroll._px4._py3,
								modal.view modal
			if t.wikiPage or t.imgurEdit
				m \._sideRight,
					switch
					| t.wikiPage
						m \._column._px5._py4,
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
					| t.imgurEdit
						m \._p3,
							m \p "Tỷ lệ h.tại: #@imgurEditRatio"
							m \p "Tỷ lệ gốc: #@imgurEditRatioOrg"
							m \p,
								class: @imgurEditRatio < @imgurEditRatio1Img and \_textRed or \_textGreen
								"Tỷ lệ 1 ảnh: #@imgurEditRatio1Img"
							m \p,
								class: @imgurEditRatio < @imgurEditRatio2Img and \_textRed or \_textGreen
								"Tỷ lệ 2 ảnh: #@imgurEditRatio2Img"

appEl = document.createElement \div
appEl.id = \_app
document.body.appendChild appEl
m.mount appEl, App
