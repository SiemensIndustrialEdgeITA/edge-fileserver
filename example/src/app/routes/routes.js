'use strict'

const path = require('path');
var fs = require('fs');

const appRouter = (app) => {

    // default route
    app.get('/', (req, res) => {
        // send index html page
        res.sendFile(path.join(__dirname + '/../templates/index.html'));
    });

    // default route
    app.get('/config', (req, res) => {

        // create base response
        let response = { data: "", error: "" };
        // try read config file from external volume linked file
        fs.readFile('/opt/app/config/config.json', (err, data) => {

            if (err) {
                // if file reading has error
                console.log(err);
                response.error = err;
                res.status(400).send(response);
            }
            else {
                console.log(data);
                // get config data and send it
                response.data = JSON.parse(data);
                res.status(200).send(response);
            }
        });

    });

};

module.exports = appRouter;