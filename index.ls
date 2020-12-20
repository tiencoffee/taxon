lineH = 15
data = await (await fetch \tree.taxon)text!
data /= \\n
tree = [0 \Organism no \/Sinh_vật [] "Sinh vật"]
refs = [tree]
headRegex = /^(\t*)(.+?)(\*)?( .+)?$/
tailRegex = /^(\/|\?|:|https?:\/\/|[a-zA-Z\d]{7}( [;|]|$))/
inaturalistRegex = /^:(\d+)([epJEP]?)$/
inaturalistExts = "": \jpg e: \jpeg p: \png J: \JPG E: \JPEG P: \PNG
lines = []
index = -1
code = void

for line in data
	imgs1 = void
	[head, text1, tail] = line.split " # "
	[, lv1, name1, ex1, disam1] = headRegex.exec head
	lv1 = lv1.length + 1
	name1 = " " if name1 is \_
	if disam1
		disam1 =
			if disam1.1 is \\
				\_( + disam1.substring(2) + \)
			else
				disam1.substring 1
	disam1 .= replace " " \_ if disam1
	ex1 = Boolean ex1
	if text1
		if tailRegex.test text1
			tail = text1
			text1 = ""
		if tail
			imgs1 = tail
				.split " | "
				.map (imgg) ~>
					[src, captn] = imgg.split " ; "
					unless src is \?
						captn = void if captn is \.
						switch src.0
						| \/
							src = "https://upload.wikimedia.org/wikipedia/commons/thumb#src/320px-#{src.substring 6}"
						| \:
							[, data, ext] = inaturalistRegex.exec src
							ext = inaturalistExts[ext]
							src = "https://static.inaturalist.org/photos/#data/medium.#ext"
						else
							src = "https://i.imgur.com/#{src}m.png"
						{src, captn}
	node = [lv1, name1, ex1, disam1,, text1, imgs1]
	if refs.some (.0 >= lv1)
		refs .= filter (.0 < lv1)
	ref = refs[* - 1]
	ref[]4.push node
	refs.push node

addNode = (node, parentLv, parentName, extinct, chrs, first, last, nextSiblExtinct) !~>
	[lv, name, ex, disam, childs, text, imgs] = node
	# if name and name.length is 5 and name isnt /^[? ]$/ and lv < 35
	# 	console.log name, node
	extinct = yes if ex
	if parentLv >= 0
		lvRange = lv - parentLv - 1
		if extinct
			chrs2 = (chrs + if first => "╸╸"repeat(lvRange) + \╸┓ else "  "repeat(lvRange) + " ╏")
				.replace /\ (?=[╸━┓])/ \╹
				.replace /┃(?=[━┓])/ \┣
		else
			chrs2 = (chrs + if first => "━━"repeat(lvRange) + \━┓ else "  "repeat(lvRange) + " ┃")
				.replace /\ (?=[╸━┓])/ \┗	
				.replace /[┃╏](?=[━┓])/ \┣
	else
		chrs2 = " ┃"
	if lv >= 35
		fullName = "#parentName #name"
	line =
		index: ++index
		lv: lv
		name: name
		text: text
		imgs: imgs
		extinct: extinct
		disam: disam
		chrs: chrs2
		fullName: fullName
	lines.push line
	if childs
		line.childs = []
		chrs += "  "repeat(lvRange) + (last and "  " or (if extinct or nextSiblExtinct => " ╏" else " ┃"))
		if (lv < 31 or lv > 34) and name not in [\? " "]
			parentName = fullName or name
		lastIndex = childs.length - 1
		for child, i in childs
			addNode child, lv, parentName, extinct, chrs, not i, i is lastIndex, childs[i + 1]?2

addNode tree, -1 "" no "" yes yes
document.body.style.height = lines.length * lineH + \px
localStorage
	..taxonFindVal ?= ""
	..taxonFindExact ?= \1
	..taxonFindCase ?= \1

App =
	oninit: !->
		for k, prop of @
			@[k] = prop.bind @ if typeof prop is \function
		@lines = []
		@lines = []
		@start = void
		@len = 0
		@finding = no
		@findVal = localStorage.taxonFindVal
		@findLines = []
		@findIndex = 0
		@findExact = !!localStorage.taxonFindExact
		@findCase = !!localStorage.taxonFindCase
		@popper = null
		@xhr = null
		@chrsRanks = [
			[\life 0 1]
			[\domain 1 2]
			[\kingdom 2 5]
			[\phylum 5 10]
			[\class 10 16]
			[\order 16 24]
			[\family 24 27]
			[\tribe 27 30]
			[\genus 30 34]
			[\species 34 36]
			[\subspecies 36 39]
		]

	oncreate: !->
		document.body.onscroll = !~>
			@goLine Math.ceil(scrollY / lineH), yes
			@mouseleaveName!
		window.onkeydown = (event) !~>
			unless event.repeat
				{code} := event
				switch code
				| \KeyF
					if document.activeElement is document.body
						@find!
						event.preventDefault!
					if event.ctrlKey
						event.preventDefault!
				| \KeyX
					if event.altKey
						@toggleFindExact!
						event.preventDefault!
				| \KeyC
					if event.altKey
						@toggleFindCase!
						event.preventDefault!
				| \Escape
					@closeFind!
		window.onkeyup = (event) !~>
			code := void
		do window.onresize = !~>
			@len = Math.ceil innerHeight / lineH
			@goLine!

	goLine: (start = @start, noScroll) !->
		start ?= +localStorage.taxonStart or 0
		if start < 0
			start = 0
		else if start > lines.length - @len + 1
			start = lines.length - @len + 1
		localStorage.taxonStart = start
		@lines = lines.slice start, start + @len
		@start = start
		scrollTo 0 start * lineH unless noScroll
		m.redraw!

	getRankName: (lv) ->
		@chrsRanks.find (.2 > lv) .0

	find: (val = @findVal) !->
		if val?
			@findVal = val
			localStorage.taxonFindVal = val
		unless @finding
			@finding = yes
			m.redraw.sync!
		findInputEl.focus!
		if val.trim!
			unless @findCase
				val .= toLowerCase!
			@findLines = lines.filter ~>
				{name, text = ""} = it
				unless @findCase
					name .= toLowerCase!
					text .= toLowerCase!
				if @findExact
					name is val or text is val
				else
					name.includes val or text.includes val
			if @findIndex >= @findLines.length
				@findIndex = @findLines.length - 1
		else
			@findLines = []
		if @findLines.length
			@findGo!
		m.redraw!

	findGo: (num = 0) !->
		if @findLines.length
			@findIndex = (@findIndex + num) %% @findLines.length
			@goLine @findLines[@findIndex]index - 4

	toggleFindExact: !->
		not= @findExact
		localStorage.taxonFindExact = @findExact and \1 or ""
		@find!

	toggleFindCase: !->
		not= @findCase
		localStorage.taxonFindCase = @findCase and \1 or ""
		@find!

	closeFind: !->
		if @finding
			@finding = no
			@findLines = []
			m.redraw!

	classLine: (line) ->
		className = \line
		className += " lineFind" if @finding and line is @findLines[@findIndex]
		className

	mousedownImg: (img, event) !->
		{target} = event
		{src} = img
		switch event.which
		| 1
			if src.includes \upload.wikimedia.org
				width = 10 * Math.round target.naturalWidth / target.naturalHeight * 80
				src .= replace /\/320px-/ "/#{width}px-"
			else
				src .= replace /(?<=:\/\/)i\.|m\.png$/g ""
			window.open src, \_blank

	mousedownName: (line, event) !->
		unless line.name in ["" \?]
			name = line.fullName or line.name
			switch event.which
			| 1
				lang = event.altKey and \vi or \en
				window.open "https://#lang.wikipedia.org/wiki/#name" \_blank
			| 2
				event.preventDefault!
				navigator.clipboard.writeText line.name

	contextmenuName: (line, event) !->
		event.preventDefault!
		name = line.fullName or line.name
		window.open "https://google.com/search?tbm=isch&q=#name" \_blank

	mouseleaveName: !->
		if @popper
			@xhr?abort!
			@popper.destroy!
			@popper = null
			m.mount popupEl

	mouseenterName: (line, event) !->
		unless line.name in [\? " "]
			count = 0
			summary = void
			{imgs} = line
			width = 320
			popup =
				view: ~>
					m \#popupBody,
						style:
							minWidth: width + \px
						m \#popupName,
							line.fullName or line.name
						if line.text
							m \#popupText that
						if imgs
							m \#popupGenders,
								class: "popupTwoImg" if imgs.0 and imgs.1
								imgs.map (img, i) ~>
									if img
										m \.popupGender,
											m \.popupPicture,
												m \img.popupBgImg,
													src: img.src
												m \img.popupImg,
													src: img.src
													onload: !~>
														@popper?forceUpdate!
											if img.captn
												m \.popupCaptn that
											if imgs.length is 2
												m \.popupGenderCaptn i && \Cái || \Đực
						if summary
							m \#popupSummary m.trust summary
			m.mount popupEl, popup
			@popper = Popper.createPopper event.target, popupEl,
				placement: \left
				strategy: \fixed
				modifiers:
					* name: \offset
						options:
							offset: [0 18]
					* name: \preventOverflow
						options:
							padding: 8
					* name: \customUpdate
						enabled: yes
						phase: \afterWrite
						fn: !~>
							if count++ < 120
								rect = popupEl.getBoundingClientRect!
								oldWidth = width
								width := rect.width - 16
								if rect.height > innerHeight - 8
									width += 8
								unless width is oldWidth
									m.redraw.sync!
									@popper.forceUpdate!
			try
				q =
					if line.disam?0 is \/
						line.disam.substring 1 or \_
					else
						(line.fullName or line.name) + (line.disam or "")
				data = await m.request do
					url: "https://vi.wikipedia.org/api/rest_v1/page/summary/#q"
					background: yes
					config: (@xhr) !~>
				if data.type is \standard and data.extract_html
					[summary] = data.extract_html is /<p>.+?<\/p>/s
				else throw
				# imgs = [src: data.thumbnail.source] if data.thumbnail and not line.imgs
			catch
				summary = "Không có dữ liệu"
			m.redraw.sync!
			@popper.forceUpdate!

	view: ->
		m \div,
			m \#presEl,
				@lines.map (line) ~>
					m \div,
						key: line.index
						class: @classLine line
						@chrsRanks.map (rank) ~>
							m \span,
								class: rank.0
								line.chrs.substring rank.1 * 2, rank.2 * 2
						m \.node,
							m \span,
								class: @getRankName line.lv
								onmouseenter: !~>
									@mouseenterName line, it
								onmouseleave: @mouseleaveName
								onmousedown: !~>
									@mousedownName line, it
								oncontextmenu: !~>
									@contextmenuName line, it
								line.name
							if line.text
								m \span.text,
									"\u2014 #{line.text}"
							line.imgs?map (img) ~>
								if img
									m \img.img,
										src: img.src
										onmousedown: !~>
											@mousedownImg img, it
			if @finding
				m \#findEl,
					m \input#findInputEl,
						placeholder: "Tìm kiếm"
						autocomplete: \off
						value: @findVal
						oninput: !~>
							@find it.target.value
						onkeydown: !~>
							if it.key is \Enter
								@findGo it.shiftKey && -1 || 1
					m \#findTextEl,
						(@findLines.length and @findIndex + 1 or 0) + \/ + @findLines.length
					m \.findButton,
						class: \findButtonOn if @findExact
						title: "Tìm chính xác"
						onclick: @toggleFindExact
						'""'
					m \.findButton,
						class: \findButtonOn if @findCase
						title: "Phân biệt hoa-thường"
						onclick: @toggleFindCase
						"Tt"
					m \.findButton#findClose,
						title: "Đóng"
						onclick: @closeFind
						"\u2a09"
			m \#popupEl

m.mount appEl, App
