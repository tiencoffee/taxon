var text="\n"+[...$0.children].map(v=>"\t".repeat(29)+v.querySelector("i").textContent+"\n"+[...v.querySelector("ul").children].map(v2=>"\t".repeat(34)+v2.textContent.split(" ")[1]).join("\n")).join("\n")
el=document.createElement("textarea")
el.value=text
document.body.appendChild(el)
el.select()
document.execCommand("copy")

////////////////////////////////

var text="\n"+[...$0.children].map(v=>"\t".repeat(29)+v.textContent.split(" ")[0]+"\n"+[...v.querySelector("ul").children].map(v2=>"\t".repeat(34)+v2.textContent.split(" ")[1]).join("\n")).join("\n")
el=document.createElement("textarea")
el.value=text
document.body.appendChild(el)
el.select()
document.execCommand("copy")

////////////////////////////////

var el = document.querySelector(".mw-parser-output")
var h3s = el.querySelectorAll(":scope>h2")
var text = ""
for (let h3 of h3s) {
	if (h3.querySelector("#References")) continue
	let ul = h3
	while (ul.tagName !== "UL") {
		ul = ul.nextElementSibling
	}
	let lis = [...ul.children]
	text += "\n" + "\t".repeat(29) + h3.children[0].textContent
	for (let li of lis) {
		let species = li.querySelector("i").textContent.split(" ")[1]
		text += "\n" + "\t".repeat(34) + species
		let ul2
		if (ul2 = li.querySelector("ul")) {
			let lis2 = [...ul2.children]
			text += "\n" + "\t".repeat(35) + species
			for (let li2 of lis2) {
				let subspecies = li2.querySelector("i").textContent.split(" ")[2]
				if (species !== subspecies) {
					text += "\n" + "\t".repeat(35) + subspecies
				}
			}
		}
	}
}
var el = document.createElement("textarea")
el.value = text
document.body.appendChild(el)
el.select()
document.execCommand("copy")
