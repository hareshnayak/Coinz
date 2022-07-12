// Imports from packages
const express = require("express");
const mongoose = require("mongoose");
const dotenv = require('dotenv').config() // to use .env file


// Import from other files

// INIT
const PORT = process.env.PORT || 3000
const app = express();
const DB = process.env.mongoDBuri;


// middelwares
app.use(express.json());


// connections
mongoose.connect(DB).then(()=>{
    console.log("connection successful");
}).catch((e)=>{
    console.log(e);
});


// 
app.get("/", (req, res) => {
    res.json({"msg": "Hello World!"});
  })


  // app listen
app.listen(PORT, "0.0.0.0", ()=>{
    console.log(`running server at ${PORT}`);
});

