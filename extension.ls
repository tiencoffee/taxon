App =
	oninit: !->
		for k, val of @
			@[k] = val.bind @ if typeof val is \function
		ranks =
			* name: \domain
				texts: [\Domain \Super-?kingdom \Vực "Siêu giới"]
			* name: \kingdom
				texts: [\Kingdom \Giới]
			* name: \subkingdom
				texts: [\Sub-?kingdom "Phân giới"]
			* name: \infrakingdom
				texts: [\Infra-?kingdom "Thứ giới"]
			* name: \superphylum
				texts: [\Super-?phylum \Super-?division "Liên ngành" "Siêu ngành"]
			* name: \phylum
				texts: [\Phylum \Division \Ngành]
			* name: \subphylum
				texts: [\Sub-?phylum \Sub-?division "Phân ngành"]
			* name: \infraphylum
				texts: [\Infra-?phylum \Infra-?division "Thứ ngành"]
			* name: \parvphylum
				texts: [\Parv-?phylum \Micro-?phylum "Tiểu ngành"]
			* name: \superclass
				texts: [\Super-?class "Liên lớp" "Siêu lớp"]
			* name: \class
				texts: [\Class \Lớp]
			* name: \subclass
				texts: [\Sub-?class "Phân lớp"]
			* name: \infraclass
				texts: [\Infra-?class "Thứ lớp"]
			* name: \parvclass
				texts: [\Parv-?class "Tiểu lớp"]
			* name: \legion
				texts: [\Legion \Đoàn]
			* name: \supercohort
				texts: [\Super-?cohort "Liên đội"]
			* name: \cohort
				texts: [\Cohort \Đội]
			* name: \magnorder
				texts: [\Magn-?order "Tổng bộ" "Đại bộ"]
			* name: \superorder
				texts: [\Super-?order "Liên bộ" "Siêu bộ"]
			* name: \order
				texts: [\Order \Bộ]
			* name: \suborder
				texts: [\Sub-?order "Phân bộ"]
			* name: \infraorder
				texts: [\Infra-?order "Thứ bộ"]
			* name: \parvorder
				texts: [\Parv-?order "Tiểu bộ"]
			* name: \superfamily
				texts: [\Super-?family "Liên họ" "Siêu họ"]
			* name: \family
				texts: [\Family \Họ]
			* name: \subfamily
				texts: [\Sub-?family "Phân họ"]
			* name: \supertribe
				texts: [\Super-?tribe "Liên tông"]
			* name: \tribe
				texts: [\Tribe \Tông]
			* name: \subtribe
				texts: [\Sub-?tribe "Phân tông"]
			* name: \genus
				texts: [\Genus \Chi]
			* name: \subgenus
				texts: [\Sub-?genus "Phân chi"]
			* name: \section
				texts: [\Section \Mục]
			* name: \series
				texts: [\Series \Loạt]
			* name: \superspecies
				texts: [\Super-?species "Liên loài"]
			* name: \species
				texts: [\Species \Loài]
			* name: \subspecies
				texts: [\Sub-?species "Phân loài"]
			* name: \variety
				texts: [\Variety \Thứ]
			* name: \form
				texts: [\Form \Dạng]
		@ranks = []
		for rank, i in ranks
			for text in rank.texts
				subrank =
					text: text
					textRegex: ///#text///i
					textStartRegex: ///^#text///i
					lv: i
					tab: \\t * i
				subrank <<< rank
				@ranks.push subrank
				@ranks[rank.name] ?= subrank
		@ranks.sort (rankA, rankB) ~>
			rankB.text.split(" ")length - rankA.text.split(" ")length or
			rankB.text.length - rankA.text.length
		@regexes = {}
			..ranksStr = @ranks.map (.text) .join \|
			..ranksStart = ///^(#{..ranksStr})[^\S\r\n]+///i
			..extinct = /\b(tuyệt chủng|extinct|fossil)\b|†/i
		@els =
			viLang: document.querySelector ".interlanguage-link-target[lang=vi]"
			enLang: document.querySelector ".interlanguage-link-target[lang=en]"
		@summ = null
		@selection = getSelection!
		@resetCombo!
		window.addEventListener \mousedown @onmousedown, yes
		window.addEventListener \mouseup @onmouseup, yes
		window.addEventListener \contextmenu @oncontextmenu, yes
		window.addEventListener \keydown @onkeydown, yes
		window.addEventListener \keyup @onkeyup, yes
		window.addEventListener \visibilitychange @onvisibilitychange, yes
		if @els.viLang
			q = that.href.split \/ .[* - 1]
			@summ = await (await fetch "https://vi.wikipedia.org/api/rest_v1/page/summary/#q")json!
			m.redraw!

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

	doCombo: (combo, target, sel, event, args) !->
		doCombo = (combo2 = combo, target2 = target, sel2 = sel, args2 = args) !~>
			@doCombo combo2, target2, sel2, event, args2
		switch
		| sel
			switch
			| combo is \Slash
				data = sel.replace @regexes.ranksStart, ""
				data = @upperFirst data
				data = " # #data"
				@copy data
				@emptySel!
		| target
			switch
			| target.localName is \img
				if combo is \RMB
					{src} = target
					if /\/\d+px-.+/.test src
						src = src
							.replace \https://upload.wikimedia.org/wikipedia/commons/thumb ""
							.replace /\/\d+px-.+$/ ""
					else if /-\d+px-.+/.test src
						src .= replace /-\d+px-/ \-220px-
					@copy src
					@mark target
			| target.closest ".infobox.biota td:scope:nth-child(2)"
				rankName = target.previousElementSibling.innerText
					.replace \: ""
					.trim!
				rank = @ranks.find (.textStartRegex.test rankName)
				if rank
					tab = rank.tab
					data = @extract target,
						tab: tab
						deep: no
					@copy data
					@mark target
			| target.localName is \li
				if combo is \RMB
					ul = target.parentElement
					data = @extract ul.children,
						initText: ~>
							li.querySelector ":scope> i> a" ?.innerText
					@copy data
					@mark ul
			| target.matches '#firstHeading, h1,h2,h3,h4,h5,h6, b'
				if combo is \RMB
					@mark target
					doCombo \Slash,, target.innerText

	extract: (targets, opts = {}, parent) ->
		targets = [targets] unless \length of targets
		targets = Array.from targets
		opts = {
			notMatchText: \?
			deep: yes
			...opts
		}
		if parent
			datas = []
		else
			datas = parent.datas
		notMatchTab = void
		for target in targets
			text = target.innerText
				.trim!
				.split \\n 1 .0
			extinct = ""
			if @regexes.extinct.test text
				extinct = \*
			tab = void
			if opts.tab?
				tab = opts.tab
			if opts.text?
				text? =
					if typeof opts.text is \function
						opts.text!
					else opts.text
			text = text
				.replace @regexes.extinct, ""
				.trim!
			if tab
				rank = @ranks.find (.tab is tab)
			else
				rank = @ranks.find (.textStartRegex.test text)
				tab = rank.tab ? ""
			notMatchTab ?= tab
			text .= replace @regexes.ranksStart, ""
			if rank
				if rank.lv is 34
					if matched = /^[A-Z][a-z]+\s([a-z-]{2,})/ is text
						text = matched.1
					else
						text = opts.notMatchText
						tab = notMatchTab
				else
					if matched = /^([A-Z][a-z]+)/ is text
						text = matched.1
					else
						text = opts.notMatchText
						tab = notMatchTab
			else
				if matched = /^[A-Z][a-z]+\s([a-z-]{2,})/ is text
					text = matched.1
					tab = @ranks.species.tab
				else if matched = /^([A-Z][a-z]+)/ is text
					text = matched.1
					tab = @ranks.genus.tab
				else
					text = opts.notMatchText
					tab = notMatchTab
			data =
				tab: tab
				text: text
				extinct: extinct
				datas: []
			datas.push data
		datas

	mark: (el) !->
		el.dataset._mark = ""
		clearTimeout el._timeout
		el._timeout = setTimeout !~>
			delete el.dataset._mark
			delete el._timeout
		, 150

	emptySel: !->
		@selection.removeAllRanges!

	copy: (text) ->
		if text
			navigator.clipboard.writeText text

	upperFirst: (text) ->
		text.charAt 0 .toUpperCase! + text.substring 1

	view: ->
		m \._row._full,
			if t.wiki
				m \._sideLeft
			m \._sideCenter._col
			if t.wiki
				m \._sideRight._column._center,
					if @summ
						m \._col._scroll._p3,
							m \h2 @summ.title
							m \img._summImg._block src: @summ.thumbnail?source
							m \._textJustify m.trust @summ.extract_html

appEl = document.createElement \div
appEl.id = \_app
document.body.appendChild appEl
m.mount appEl, App
