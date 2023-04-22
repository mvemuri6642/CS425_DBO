# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

from flask import Flask,redirect, url_for,render_template,request

import cgi
import cgitb
import mysql.connector
from decimal import Decimal

# Enable debug output
cgitb.enable()

# Get the form data
form = cgi.FieldStorage()
mydb = mysql.connector.connect(host="localhost",user="root",password="manu",database="manohar")
mycursor = mydb.cursor()
app=Flask(__name__)
@app.route("/",methods=['POST','GET'])
def login():
    if(request.method=="POST"): 
        username=request.form["username"]
        password=request.form['password']

        mycursor.execute("SELECT type FROM users WHERE email=%s AND password=%s", (username, password))
        # print("<h1>hi</h1>")
        result = mycursor.fetchone()
        if result==('perspective_renter',):
            return redirect(url_for("renter",email=username))
        else:
            return redirect(url_for("agent",email=username))
        print(result)
    else:
        return render_template("index.html")
@app.route("/register",methods=['POST','GET'])
def register():
    if(request.method=="POST"): 
        # mydb = mysql.connector.connect(host="localhost",user="root",password="manu",database="manohar")
        # mycursor = mydb.cursor()
        name=request.form["name"]
        email=request.form["email"]
        phone=request.form["phone"]
        password=request.form['password']
        type=request.form['type']
        if(type=='renter'):
            location=request.form['location']
            budget=request.form['budget']
            # movein=request.form['movein']
            movein=str('2022-02-02')
            query_users='insert into users values(%s,%s,%s,%s)'
            query_renters='insert into perspective_renters(emailID,name,move_in_date,location,budget) values(%s,%s,%s,%s,%s)'
            mycursor.execute(query_users,(name,email,password,'perspective_renter'))
            mycursor.execute(query_renters, (email, name,movein,location,budget))
            mydb.commit()
        else:
            agency=request.form['agency']
            query_users='insert into users values(%s,%s,%s,%s)'
            query_agents='insert into agents values(%s,%s,%s,%s,%s)'
            mycursor.execute(query_users,(name,email,password,'agent'))
            mycursor.execute(query_agents,(email,name,'emp',agency,phone))
            mydb.commit()
    else:
        return render_template("register.html")


@app.route('/<email>')
def renter(email):
    query_property='select * from property'
    mycursor.execute(query_property)
    data = mycursor.fetchall()
    query_bookings='select * from bookingrecords where emailID=%s'
    mycursor.execute(query_bookings,[email])
    bookings=mycursor.fetchall()
    print(bookings)
    return render_template("homepage_renters.html",data=data,bookings=bookings)

@app.route('/agent<email>')
def agent(email):

    return render_template('homepage_agent.html',email=email)
    print(email)

@app.route('/bookings<data>')
def bookings(data):
    data=eval(data)
    return render_template("bookings.html",data=data)


@app.route('/ads<email>')
def ads(email):
    query_ads='select * from property where emailID=%s'
    mycursor.execute(query_ads,[email])
    ads=mycursor.fetchall()
    return render_template("ads.html",ads=ads)

if __name__=="__main__":
    app.run(debug=True)