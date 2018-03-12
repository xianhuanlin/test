

var a = ['a','ec','ed','dd']
var b = ['dd2','dd344','dd5']
for (t in b){
    a.push(b[t])
}

var c = {}
// a.push('ff')

console.log(Object.getOwnPropertyNames(c).length)
console.log(a.indexOf(''))
console.log(a)

var st = 'abc'
if (st.indexOf('abc') >= 0){
    console.log('ok')
}

if (a.bcd == undefined || b.length == 0){
    console.log('ok')
}
