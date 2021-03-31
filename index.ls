localStorage
	..taxonFindExact ?= \1
	..taxonFindCase ?= \1
	..taxonInfoLv ?= 1
	..rightClickAction ?= \n
lineH = 15
data = await (await fetch \tree.taxon)text!
data /= \\n
tree = [0 \Organism no \/Sinh_vật [] "Sinh vật"]
refs = [tree]
headRegex = /^(\t*)(.+?)(\*)?( .+)?$/
tailRegex = /^([-/:@%~^+?]|https?:\/\/)/
inaturalistRegex = /^(:?)(\d+)([epJEPu]?)$/
inaturalistExts = "": \jpg e: \jpeg p: \png J: \JPG E: \JPEG P: \PNG u: ""
bugguideRegex = /^([A-Z\d]+)([r]?)$/
bugguideTypes = "": \cache r: \raw
lines = []
index = -1
chars = {}
charsId = 0
code = void
numFmt = new Intl.NumberFormat \en
infoMaxLv = 2
infoLv = +localStorage.taxonInfoLv
infos =
	taxon:
		label: "Tổng số taxon"
		lv: 1
	family:
		label: "Tổng số họ"
	genus:
		label: "Tổng số chi"
	speciesSubsp:
		label: "Tổng số loài, phân loài"
		lv: 1
	speciesSubspExists:
		label: "Loài, phân loài còn tồn tại"
	speciesSubspExtinct:
		label: "Loài, phân loài tuyệt chủng"
	speciesSubspHasViName:
		label: "Loài, phân loài có tên tiếng Việt"
	speciesSubspHasImg:
		label: "Loài, phân loài có hình ảnh"
		lv: 1
	img:
		label: "Tổng số hình ảnh"
		lv: 1
for , info of infos
	info.lv ?= infoMaxLv
	info.count = 0

for line in data
	imgs = void
	[head, text, tail] = line.split " # "
	[, lv, name, ex, disam] = headRegex.exec head
	lv = lv.length + 1
	# continue if lv > 20
	name = " " if name is \_
	if disam
		disam =
			if disam.1 is \\
				\_( + disam.substring(2) + \)
			else
				disam.substring 1
	disam .= replace " " \_ if disam
	ex = Boolean ex
	if text
		if tailRegex.test text
			tail = text
			text = ""
		if tail
			imgs = tail
				.split " | "
				.map (imgg) ~>
					[src, captn] = imgg.split " ; "
					unless src is \?
						captn = void if captn is \.
						key = src.0
						src .= substring 1
						switch key
						| \-
							src = "https://i.imgur.com/#{src}m.png"
						| \/
							if src.0 is \/
								type = \en
								src .= substring 1
							else
								type = \commons
							src = "https://upload.wikimedia.org/wikipedia/#type/thumb/#{src.0}/#src/320px-..webp"
						| \:
							[, host, src, ext] = inaturalistRegex.exec src
							host = host and \inaturalist-open-data.s3.amazonaws.com or \static.inaturalist.org
							ext = inaturalistExts[ext]
							src = "https://#host/photos/#src/medium.#ext"
						| \@
							src = "https://live.staticflickr.com/#{src}_n.jpg"
						| \%
							src = "https://www.biolib.cz/IMG/GAL/#src.jpg"
						| \~
							[, src, type] = bugguideRegex.exec src
							type = bugguideTypes[type]
							src = "https://bugguide.net/images/#type/#{src.substring 0 3}/#{src.substring 3 6}/#src.jpg"
						| \^
							if src.0 is \^
								path = \tools/UploadPhoto/uploads
								src .= substring 1
							else
								path = \images/species
							src = "https://fishbase.us/#path/#src.jpg"
						| \+
							src = "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/#{src}1/320"
						else
							src .= replace /^ttps?:/ ""
						infos.img.count++
						{src, captn}
	node = [lv, name, ex, disam,, text, imgs]
	if refs.some (.0 >= lv)
		refs .= filter (.0 < lv)
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
	if chars[chrs2]?
		chrs2 = chars[chrs2]
	else
		chrs2 = chars[chrs2] = charsId++
	lteSpecies = lv > 34
	if lteSpecies
		fullName = "#parentName #name"
		unless childs
			infos.speciesSubsp.count++
			infos.speciesSubspHasImg.count++ if imgs
			infos.speciesSubspHasViName.count++ if text
			infos.speciesSubspExtinct.count++ if extinct
	else if lv is 30
		infos.genus.count++
	else if lv is 25
		infos.family.count++
	line =
		index: ++index
		lv: lv
		name: name
		chrs: chrs2
	line.text? = text
	line.imgs? = imgs
	line.extinct? = extinct
	line.disam? = disam
	line.fullName? = fullName
	lines.push line
	if childs
		line.childs = []
		chrs += "  "repeat(lvRange) + (last and "  " or (if extinct or nextSiblExtinct => " ╏" else " ┃"))
		if lv < 32 or lteSpecies
			if name not in [\? " "]
				if lv is 31
					parentName = "#parentName (#name)"
				else
					parentName = fullName or name
			else if lv is 30
				parentName = \" + parentName + \"
		lastIndex = childs.length - 1
		for child, i in childs
			addNode child, lv, parentName, extinct, chrs, not i, i is lastIndex, childs[i + 1]?2

addNode tree, -1 "" no "" yes yes
chars = Object.keys chars
infos.taxon.count = lines.length
infos.speciesSubspExists.count = infos.speciesSubsp.count - infos.speciesSubspExtinct.count
for , info of infos
	info.count = numFmt.format info.count

App =
	oninit: !->
		for k, prop of @
			@[k] = prop.bind @ if typeof prop is \function
		@lines = []
		@start = void
		@len = 0
		@finding = no
		@findVal = ""
		@findLines = []
		@findIndex = 0
		@findExact = !!localStorage.taxonFindExact
		@findCase = !!localStorage.taxonFindCase
		@popper = null
		@xhr = null
		@chrsRanks =
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
		@rightClickAction = localStorage.taxonRightClickAction

	oncreate: !->
		heightEl.style.height = lines.length * lineH + \px
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
					if @finding
						if event.altKey
							@toggleFindExact!
							event.preventDefault!
				| \KeyC
					if @finding
						if event.altKey
							@toggleFindCase!
							event.preventDefault!
				| \KeyI
					if document.activeElement is document.body
						val = event.shiftKey and 2 or 1
						infoLv := if infoLv and infoLv is val => 0 else val
						localStorage.taxonInfoLv = infoLv
						m.redraw!
				| \KeyA
					if document.activeElement is document.body
						action = prompt """
							Nhập hành động khi bấm chuột phải:
							g: google
							b: bugguide
							l: biolib
							h: fishbase
							e: ebird
							s: seriouslyfish
							n: inaturalist (mặc định)
						""" @rightClickAction
						if action
							@rightClickAction = action
							localStorage.taxonRightClickAction = action
				| \Escape
					if @finding
						@closeFind!
		window.onkeyup = window.onblur = (event) !~>
			code := void
		scrollEl.scrollTop = +localStorage.taxonTop or 0
		scrollEl.style.scrollBehavior = \smooth
		do window.onresize = !~>
			@len = Math.ceil(innerHeight / lineH) + 1
			@onscrollScroll!
			m.redraw!

	getRankName: (lv) ->
		@chrsRanks.find (.2 > lv) .0

	find: (val = @findVal) !->
		@findVal? = val
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
			scrollEl.scrollTop = (@findLines[@findIndex]index - 4) * lineH
			@onscrollScroll!

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
			switch
			| src.includes \upload.wikimedia.org
				width = 10 * Math.round target.naturalWidth / target.naturalHeight * 80
				src .= replace /\/320px-/ "/#{width}px-"
			| src.includes \static.inaturalist.org
				src .= replace \/medium. \/large.
			| src.includes \live.staticflickr.com
				src .= replace \_n. \.
			# | src.includes \biolib.cz
			# 	src .= replace \/GAL/ \/GAL/BIG/
			| src.includes \cdn.download.ams.birds.cornell.edu
				src .= replace /\d+$/ \1800
			| src.includes \i.imgur.com
				src -= /(?<=:\/\/)i\.|m\.png$/g
				src += \?_taxonDelete=1 if code is \Delete
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
				await navigator.clipboard.writeText line.name

	contextmenuName: (line, event) !->
		event.preventDefault!
		unless line.name in ["" \?]
			name = line.fullName or line.name
			action =
				| event.altKey => \g
				| code is \KeyB => \b
				| code is \KeyL => \l
				| code is \KeyH => \h
				| code is \KeyE => \e
				| code is \KeyS => \s
				| code is \KeyN => \n
				else @rightClickAction
			text = name.split " " .0
			await navigator.clipboard.writeText text
			switch action
			| \g
				window.open "https://google.com/search?tbm=isch&q=#name" \_blank
			| \b
				window.open "https://bugguide.net/index.php?q=search&keys=#name"
			| \l
				window.open "https://www.biolib.cz/en/formsearch/?string=#name&searchgallery=1&action=execute"
			| \h
				[genus, species] = name.split " "
				if species
					window.open "https://fishbase.us/photos/ThumbnailsSummary.php?Genus=#genus&Species=#species" \_blank
				else
					window.open "http://fishbase.us/Nomenclature/ValidNameList.php?syng=#genus&crit2=CONTAINS&crit1=EQUAL"
			| \e
				data = await (await fetch "https://api.ebird.org/v2/ref/taxon/find?key=jfekjedvescr&q=#name")json!
				item = data.find (.name.includes name) or data.0
				window.open "https://ebird.org/species/#{item.code}" if item
			| \s
				name = name.toLowerCase!replace /\ /g \-
				window.open "https://www.seriouslyfish.com/species/#name"
			else
				window.open "https://inaturalist.org/taxa/search?view=list&q=#name"

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
			imgCaptnPlch = imgs?some (?captn) and \-
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
											m \.popupCaptn img.captn || imgCaptnPlch
											if imgs.length is 2
												m \.popupGenderCaptn i && \Cái || \Đực
						if summary
							m \#popupSummary m.trust summary
			m.mount popupEl, popup
			@popper = Popper.createPopper event.target, popupEl,
				placement: \left
				modifiers:
					* name: \offset
						options:
							offset: [0 18]
					* name: \preventOverflow
						options:
							padding: 2
					* name: \customUpdate
						enabled: yes
						phase: \afterWrite
						fn: !~>
							if count++ < 120
								rect = popupEl.getBoundingClientRect!
								if rect.height > innerHeight - 8
									width += 8
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
					summary = data.extract_html.replace /\n+/g " "
					summary = /<p>(.+?)<\/p>/uexec summary .0
				else throw
				# imgs = [src: data.thumbnail.source] if data.thumbnail and not line.imgs
			catch
				summary = "Không có dữ liệu"
			m.redraw.sync!
			@popper.forceUpdate!

	onscrollScroll: (evt) !->
		evt.redraw = no if evt
		top = scrollEl.scrollTop
		mod = top % lineH
		presEl.style.transform = "translateY(#{top - mod}px)"
		localStorage.taxonTop = top
		start = Math.floor top / lineH
		unless start is @start and @lines.length is @len
			@start = start
			@lines = lines.slice start, start + @len
			evt.redraw = yes if evt
		@mouseleaveName!

	view: ->
		m \div,
			m \#scrollEl,
				onscroll: @onscrollScroll
				m \#presEl,
					@lines.map (line) ~>
						m \div,
							key: line.index
							class: @classLine line
							@chrsRanks.map (rank) ~>
								m \span,
									class: rank.0
									chars[line.chrs]substring rank.1 * 2, rank.2 * 2
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
				m \#heightEl
			if infoLv
				m \#infosEl,
					for , info of infos
						if infoLv >= info.lv
							m.fragment do
								m \.info info.label
								m \.info info.count
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
