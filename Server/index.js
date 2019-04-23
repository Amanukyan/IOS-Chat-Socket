/* =======================
    DEPENDENCIES
==========================*/
const mongoose = require('mongoose')
const express = require('express')
const app = express()
const http = require('http').Server(app)
const bodyParser = require('body-parser')
const morgan = require('morgan')

const routes = require('./src/routes')

/* =======================
    CONFIG
==========================*/
const port = process.env.PORT || 3000
const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://localhost/loginIOS_dev'
const secret = "barev"

/* =======================
    CONNECT TO MONGODB 
==========================*/
mongoose.connect(MONGODB_URI, { useNewUrlParser: true })
mongoose.Promise = global.Promise
const db = mongoose.connection
db.on('error', console.error)
db.once('open', ()=>{
    console.log('connected to mongodb server')
})

/* =======================
    EXPRESS
==========================*/

// parse JSON and url-encoded query
app.use(bodyParser.urlencoded({extended: true}))
app.use(bodyParser.json())

// print the request log on console
app.use(morgan('dev'))

// set the secret key variable for jwt
app.set('jwt-secret', secret)

// configure api router
app.use('/api', routes)

// index page
app.get('/', (req, res) => res.send('Hello World!'))

// open the server
http.listen(port, function() {
	console.log("Listening on port " + port);
});
