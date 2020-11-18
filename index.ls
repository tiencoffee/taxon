data = await (await fetch \tree.taxon)text!
data /= \\n
tree = [0 \Life no,, "Sự sống"]
refs = [tree]
headRegex = /^(\t*)(.+?)(\*?)$/
textRegex = /^(\/|\?|@|https?\:\/\/|[a-zA-Z0-9]{7}( [;|]|$))/
imgurIdRegex = /^[a-zA-Z0-9]{7}$/
lines = []
index = -1

mapImggFn = (imgg) ~>
	[src, captn] = imgg.split " ; "
	unless src is \?
		captn = "" if captn is \.
		if imgurIdRegex.test src
			src = "https://i.imgur.com/#{src}m.png"
		else if src.0 is \/
			src = "https://upload.wikimedia.org/wikipedia/commons/thumb#src/320px-#{src.slice 6}"
		{src, captn}
for line in data
	imgs1 = void
	[head, text1, tail] = line.split " # "
	[, lv1, name1, sym1] = headRegex.exec head
	lv1 = lv1.length + 1
	name1 = " " if name1 is \_
	if text1
		if textRegex.test text1
			tail = text1
			text1 = ""
		if tail
			imgs1 = tail
				.split " | "
				.map mapImggFn
	node = [lv1, name1, sym1,, text1, imgs1]
	if refs.some (.0 >= lv1)
		refs .= filter (.0 < lv1)
	ref = refs[* - 1]
	ref[]3.push node
	refs.push node

addNode = (node, parentLv, parentName, extinct, chrs, first, last, nextSiblExtinct) !~>
	[lv, name, sym, childs, text, imgs] = node
	extinct = yes if sym is \*
	if parentLv >= 0
		lvRange = lv - parentLv - 1
		if extinct
			chrs2 = (chrs + if first => "╴╴"repeat(lvRange) + \╴┐ else "  "repeat(lvRange) + " ¦")
				.replace /\ (?=[╴─┐])/ \'
				.replace /│(?=[─┐])/ \├
		else
			chrs2 = (chrs + if first => "──"repeat(lvRange) + \─┐ else "  "repeat(lvRange) + " │")
				.replace /\ (?=[╴─┐])/ \└
				.replace /[│¦](?=[─┐])/ \├
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
		chrs: chrs2
		fullName: fullName
	lines.push line
	if childs
		line.childs = []
		chrs += "  "repeat(lvRange) + (last and "  " or (if extinct or nextSiblExtinct => " ¦" else " │"))
		if (lv < 31 or lv > 34) and name not in [\? " "]
			parentName = fullName or name
		lastIndex = childs.length - 1
		for child, i in childs
			addNode child, lv, parentName, extinct, chrs, not i, i is lastIndex, childs[i + 1]?2

addNode tree, -1 "" no "" yes yes
document.body.style.height = lines.length * 18 + \px

App =
	oninit: !->
		for k, prop of @
			@[k] = prop.bind @ if typeof prop is \function
		@lines = []
		@lines = []
		@start = void
		@len = 0
		@findLines = []
		@findIndex = 0
		@finding = no
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
		scrollTo 0 start * 18 unless noScroll
		m.redraw!

	getRankName: (lv) ->
		@chrsRanks.find (.2 > lv) .0

	mouseenterNode: (line, event) !->
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
											m \.popupImgs,
												m \img.popupImg,
													src: img.src
													onload: @onLoadPopupImg
												if img.captn
													m \.popupCaptn that
											if line.imgs.1
												m \.popupGenderCaptn i && \Cái || \Đực
						if summary
							m \#popupSummary m.trust that
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
				q = line.fullName or line.name
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

	mouseleaveNode: !->
		if @popper
			@xhr?abort!
			@popper.destroy!
			@popper = null
			m.mount popupEl

	clickNode: (line) !->
		unless line.name in ["" \?]
			lang = event.altKey and \vi or \en
			open "https://#lang.wikipedia.org/wiki/#{line.fullName or line.name}" \_blank

	contextmenuNode: (line, event) !->
		event.preventDefault!
		unless line.name in ["" \?]
			open "https://google.com/search?tbm=isch&q=#{line.fullName or line.name}" \_blank

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
			@goLine Math.ceil(scrollY / 18), yes
		window.onkeydown = (event) !~>
			unless event.repeat
				switch event.code
				| \KeyF
					if @finding
						if document.activeElement is document.body
							findInputEl.focus!
							event.preventDefault!
					else
						@finding = yes
						setTimeout !~>
							findInputEl.focus!
						event.preventDefault!
				| \Escape
					@finding = no
				m.redraw!
		do window.onresize = !~>
			@len = Math.ceil innerHeight / 18
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
							m \b,
								class: @getRankName line.lv
								onmouseenter: !~>
									@mouseenterNode line, it
								onmouseleave: @mouseleaveNode
								onclick: !~>
									@clickNode line
								oncontextmenu: !~>
									@contextmenuNode line, it
								line.name
							if line.text
								m \span.text,
									"\u2014 #{line.text}"
							line.imgs?map (img) ~>
								if img
									m \img.img {img.src}
			if @finding
				m \#findEl,
					m \input#findInputEl,
						autocomplete: no
						oninput: !~>
							@find it.target.value
						onkeydown: !~>
							if it.key is \Enter
								@findGo it.shiftKey && -1 || 1
					m \span#findTextEl,
						(@findLines.length and @findIndex + 1 or 0) + \/ + @findLines.length
			m \#popupEl

m.mount appEl, App
