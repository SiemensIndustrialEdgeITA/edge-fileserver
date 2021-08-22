'use strict'

// packages for API Server App
const express = require('express');
const cors = require('cors');
const app = express();
var fs = require('fs')
var https = require('https')

// define some default properties for server
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(express.static('static'));

// load all API Routes
const routes = require('./routes/routes.js')(app);

// // create server HTTPS
// const server = https.createServer({
//   key: fs.readFileSync('certs/server.key'),
//   cert: fs.readFileSync('certs/server.cert')
// }, app)
//   .listen(5000, function () {
//     console.log('listening on port %s...', server.address().port);
//   })

//create server HTTP
const server = app.listen(5000, () => {
    console.log('listening on port %s...', server.address().port);
});