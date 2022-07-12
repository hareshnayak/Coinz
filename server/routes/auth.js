const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();

authRouter.post("/api/signup", async (req,res)=>{
    try{
        const {name, email, password} = req.body;

        const existingUser = await User.findOne({email});
        if(existingUser){
            return res.status(400).json({
                msg: "User with same email email exists"
            });
        }

        const hashPassword = await bcryptjs.hash(password, 10);

        let user = await User({
            email: email,
            password: hashPassword, 
            name: name
        })
    
        user = await user.save();
        res.json(user);
    }catch(e){
        res.status(500).json({error: e.message});
    }

    
});



module.exports = {authRouter : authRouter};