//
//  07.Archiving Swift Objects with Codable.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/7/21.
//

import Foundation


//UserDefaults is great for storing simple settings such as integers and Booleans, but when it comes to complex data - custom Swift types, for example - we need to do a little more work.

//Here's a simple User data structure we can work with:

/*
 struct User {
    var firstName: String
    var lasName: String
 }
 */
//That has two strings, but those aren't special - they are just pieces of text. The same goes for integer (plain old numbers), Booleans (true or false), and Double (plain old numbers, just with a dot somehwere in there). Even arrays and dictionaries of those values are easy to think abou: there's one string, then another, then a thrid, and so on.

//When working with data like this, Swift gives us a fantastic protocol called Codable: a protocol specifically for archiving and unarchiving data, which is fancy way of saying "converting objects into plain text and back again."

//We're going to be looking at Codable much more in future projects, but for now our needs are simple: we want to archive a custom type so we can put it into UserDefaults, then unarchive it when it comes back out from UserDefaults.

//When working with a type that only has simple properties - strings, integers, Booleans, arrays of strings, and so one - the only thing we need to do to support archiving and unarchiving is add a conformance to Codable, like this:

/*
 struct User: Codable {
    var firstName: String
    var lastName: String
 }
 */

//Swift will automatically generate some code for us that will archive and unarchive User instances for us as needed, but we still need to tell Swift when to archive and what to do with the data.

//The part of the process is powered by a new type called JSONEncoder. Its job is to take something that conforms toCodable and send back that object in JavaScript Object Notation (JSON) - the name implies it's specific to JavaScript, but in practice we all use it because it's so simple and fast.

//The Codable protocol doesn't require that we use JSON, and in fact other formats are available, but it is by far the most commoong. In this instance, we don't actually care what sort of data is used, because it's just goingot obe stored in UserDefaults.

//To convert our user data into JSON data, we need to call the encode() method on a JSONEncoder. This might throw errors, so it should be called with try or try? to handle errors neatly. For example, if we had a property to store a User instance, like this:

/*
 Button("Save User") {
    let encoder = JSONEncoder()
 
    if let data = try? encoder.encode(self.user) {
        UserDefaults.standard.set(data, forKey: "UserData")
    }
 }
 */

//That data constant is a new data type called, perhaps confusingly, Data. It's designed to store any kind of data you can think of, such as strings, images, zip files, and more. Here, though, all we care about is that it's one of the types of data we can write straight into UserDefaults.

//When we're coming back the other way - when we have JSON data and we want to convert it to Swift Codable types - we should use JSONDecoder rather than JSONEncoder(), but the process is much the same.

//That brings us to the end of our project overview, so go ahead and reset your project to its initial state ready to build on. 
