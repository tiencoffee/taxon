lineH = 18
data = await (await fetch \tree.taxon)text!
data /= \\n
tree = [0 \Life no, no, [], "Sự sống"]
refs = [tree]
headRegex = /^(\t*)(.+?)(\*)?( \(.*?\))?$/
textRegex = /^(\/|\?|@|https?\:\/\/|[a-zA-Z\d]{7}( [;|]|$))/
imgurIdRegex = /^[a-zA-Z\d]{7}$/
lines = []
index = -1
code = void

mapImggFn = (imgg) ~>
	[src, captn] = imgg.split " ; "
	unless src is \?
		captn = "" if captn is \.
		if imgurIdRegex.test src
			src = "https://i.imgur.com/#{src}m.png"
		else if src.0 is \/
			src = "https://upload.wikimedia.org/wikipedia/commons/thumb#src/320px-#{src.substring 6}"
		{src, captn}

for line in data
	imgs1 = void
	[head, text1, tail] = line.split " # "
	[, lv1, name1, ex1, disam1] = headRegex.exec head
	lv1 = lv1.length + 1
	name1 = " " if name1 is \_
	disam1 .= replace " " \_ if disam1
	ex1 = Boolean ex1
	if text1
		if textRegex.test text1
			tail = text1
			text1 = ""
		if tail
			imgs1 = tail
				.split " | "
				.map mapImggFn
	node = [lv1, name1, ex1, disam1,, text1, imgs1]
	if refs.some (.0 >= lv1)
		refs .= filter (.0 < lv1)
	ref = refs[* - 1]
	ref[]4.push node
	refs.push node

addNode = (node, parentLv, parentName, extinct, chrs, first, last, nextSiblExtinct) !~>
	[lv, name, ex, disam, childs, text, imgs] = node
	# if name and name.length is 4 and name isnt /^[? ]$/ and lv < 35
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
		chrs2 = "  "
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

App =
	oninit: !->
		for k, prop of @
			@[k] = prop.bind @ if typeof prop is \function
		@lines = []
		@lines = []
		@start = void
		@len = 0
		@finding = no
		@findLines = []
		@findIndex = 0
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

	goLine: (start = @start, noScroll) !->
		start ?= +localStorage.taxonomyStart or 0
		if start < 0
			start = 0
		else if start > lines.length - @len + 1
			start = lines.length - @len + 1
		localStorage.taxonomyStart = start
		@lines = lines.slice start, start + @len
		@start = start
		scrollTo 0 start * lineH unless noScroll
		m.redraw!

	getRankName: (lv) ->
		@chrsRanks.find (.2 > lv) .0

	mouseenterName: (line, event) !->
		unless line.name in [\? " "]
			count = 0
			summary = ""
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
						if line.imgs
							m \#popupGenders,
								class: "popupTwoImg" if line.imgs.0 and line.imgs.1
								line.imgs.map (img, i) ~>
									if img
										m \.popupGender,
											m \.popupPicture,
												m \img.popupBgImg,
													src: img.src
												m \img.popupImg,
													src: img.src
													onload: @onLoadPopupImg
											if img.captn
												m \.popupCaptn that
											if line.imgs.length is 2
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
									@popper.update!
			try
				q = (line.fullName or line.name) + (line.disam or "")
				data = await m.request do
					url: "https://vi.wikipedia.org/api/rest_v1/page/summary/#q"
					background: yes
					config: (@xhr) !~>
				if data.type is \standard and data.extract_html
					[summary] = data.extract_html is /<p>.+?<\/p>/
				else throw
				# line.imgs = [[[data.thumbnail.source, no]]] if data.thumbnail and not line.imgs
			catch
				summary = "Không có dữ liệu"
			m.redraw.sync!
			@popper.update!

	mouseleaveName: !->
		if @popper
			@xhr?abort!
			@popper.destroy!
			@popper = null
			m.mount popupEl

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

	find: (val) !->
		if val = val.trim!toLowerCase!
			@findLines = lines.filter ~>
				it.name.toLowerCase!includes val or
				it.text?toLowerCase!includes val
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

	classLine: (line) ->
		className = \line
		className += " lineFind" if @finding and line is @findLines[@findIndex]
		className

	onLoadPopupImg: !->
		@popper?update!

	oncreate: !->
		document.body.onscroll = !~>
			@goLine Math.ceil(scrollY / lineH), yes
		window.onkeydown = (event) !~>
			unless event.repeat
				{code} := event
				switch code
				| \KeyF
					if @finding
						if document.activeElement is document.body
							findInputEl.focus!
							event.preventDefault!
					else
						@finding = yes
						setTimeout !~>
							findInputEl.focus!
						, 5
						event.preventDefault!
						m.redraw!
				| \Escape
					if @finding
						@finding = no
						@findLines = []
						@findIndex = 0
						m.redraw!
		window.onkeyup = (event) !~>
			code := void
		do window.onresize = !~>
			@len = Math.ceil innerHeight / lineH
			@goLine!

	view: ->
		m \div,
			m \#presEl,
				@lines.map (line) ~>
					m \div,
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
						autocomplete: \off
						oninput: !~>
							@find it.target.value
						onkeydown: !~>
							if it.key is \Enter
								@findGo it.shiftKey && -1 || 1
					m \span#findTextEl,
						(@findLines.length and @findIndex + 1 or 0) + \/ + @findLines.length
			m \#popupEl

m.mount appEl, App
