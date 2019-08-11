const express = require('express')
const bodyParser = require('body-parser')
const port = 3000

const handle = (req, res) => {
    console.log(req.body)
    res.end('got it')
}

const app = express()

app.use(bodyParser.text())

app.use(handle)

app.listen(port, (err) => {
    if (err) {
        return console.log(err)
    }
    console.log('server is listening on '+ port)
})