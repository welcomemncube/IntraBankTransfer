//Require module
require('@instana/collector')();
const express = require('express');
var bodyParser = require('body-parser')

// Express Initialize
const app = express();
app.use(bodyParser.json());
const port = 8000;
app.listen(port,()=> {
  console.log('listen port 8000');
})

//app.get('/notificationService', (req,res)=>{
//  res.header("Content-Type", "application/json");
//  res.send('{"status": "Accepted", "notificationId": "1234567890"}');
//})

app.post('/notificationService', (req,res)=>{
  console.log('Request Data='+JSON.stringify(req.body));
  console.log('Request Data='+JSON.stringify(req.headers));

  for (const property in req.headers) {
    var header = property;
    var value = req.headers[property];
    console.log("Setting response header '"+header+"' to '"+value+"'");
    res.setHeader(header, value);
  };

  res.header("Content-Type", "application/json");
  res.send('{"status": "Accepted", "notificationId": "1234567890"}');
})

