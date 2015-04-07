//CVICU app Main Server
//Created by Yicheng Wang on April/04/2015
//Copyright (c) 2015 Yicheng Wang. All rights reserved.
//=====================================================


//set up pkgs.
var bodyParser = require('body-parser');
var app = require('express')();
var multer = require('multer');
var db =require('mysql');

//config app
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));
app.use(multer());

//working part
app.post('/',function(req,res){ // get requests
	var Action = req.body;
	//login in action
	if(Action['Target Action'] == 'Log In'){
	    var username = Action['UserName'];
	    var password = Action['PassWord'];
	    var conninfo = {
	    host:'127.0.0.1',
	    user:'root',
	    password:'mysql',
	    port:3307
	    };
	    var connection = db.createConnection(conninfo);
	    connection.connect();
	    connection.query('use cvicu');
	    connection.query('select * from physicians where email=?',username,function(err,result){
		    if(err){
			console.log(err.stack);
		    }
		    else{
			if(isEmpty(result)){ // no such user exists.
			    var backjson = {
				"BackMsg":"LogInRes",
				"Result":"false"
			    };
			    var backmsg = JSON.stringify(backjson);
			    res.write(backmsg);
			    res.end();
			}
			else{
			    var pass = result[0]['password'];
			    if(pass == password){ // send successful msg.
				var backjson = {
				    "BackMsg":"LogInRes",
				    "Result":"true"
				};
				var backmsg = JSON.stringify(backjson);
				res.write(backmsg);
				res.end();
			    }
			    else{// wrong pass
				var backjson = {
				    "BackMsg":"LogInRes",
				    "Result":"false"
				};
				var backmsg = JSON.stringify(backjson);
				res.write(backmsg);
				res.end();
			    }
			}
		    }
		});
	    connection.end();
	} // Login in end
	
	//request patient list
	if(Action['Target Action'] == 'Patients'){
	    var conninfo = {
	    host:'127.0.0.1',
	    user:'root',
	    password:'mysql',
	    port:3307
	    };
	    var connection = db.createConnection(conninfo);
	    connection.connect();
	    connection.query('use cvicu');
	    connection.query('select * from patients',function(err,result){
		    if(err){
			console.log(err.stack);
		    }
		    else{
			var backmsg = JSON.stringify(result);
			res.write(backmsg);
			res.end();
		    }
		});
	    connection.end();
	} // request patient list ends
      
	//add log request handle
	if(Action['Target Action'] == 'add log'){
	    var conninfo = {
	    host:'127.0.0.1',
	    user:'root',
	    password:'mysql',
	    port:3307
	    };
	    var connection = db.createConnection(conninfo);
	    //add to CPRLog
	    if(Action['Table'] == 'CPRLog'){
		var log = {
		    'FIN':Action['FIN'],
		    'startDate':Action['startDate'],
		    'endDate':Action['endDate'],
		    'outcome':Action['outcome'],
		    'Hypothermia':Action['hypothermia']
		};
		connection.query('use cvicu');
		connection.query('insert into cprlog set ?',log,function(err,result){
			if(err){
			    var backjson = {
				'BackMsg':'add back',
				'Result':'false'
			    };
			    var backmsg = JSON.stringify(backjson);
			    res.write(backmsg);
			    res.end();
			}
			else{
			    var backjson = {
				'BackMsg':'add back',
				'Result':'true'
			    };
			    var backmsg = JSON.stringify(backjson);
			    res.write(backmsg);
			    res.end();
			}
		    });
		connection.end();
	    }//end add to CPRLog
	} // add log end here
	       
    });

app.listen(3000);
console.log('server running');


//Helping Functions

function isEmpty(obj) { // check if object is empty
    return !Object.keys(obj).length;
}