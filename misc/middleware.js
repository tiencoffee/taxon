(async function(){var e;e=require("node-fetch"),module.exports=async function(t,a,n){var i,r,s,c,o;if(i=/^\/q\/(\w+)\/(.*)$/.exec(t.url))switch(a.setHeader("Access-Control-Allow-Origin","*"),r=i[1],s=i[2],r){case"img":o="data:"+(c=await e(s)).headers.get("Content-Type")+";base64,"+(await c.buffer()).toString("base64"),a.setHeader("Content-Type","plain/text"),a.end(o)}n()}}).call(this);