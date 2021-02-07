//
//  File.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/7/21.
//

import Foundation

//MARK: Day 37: Project 7, Part 2

//Today you're going to build a complete app using @ObservedObject, @Published, sheet(), Codable, UserDefaults, and more. I realize that seems like a lot, but I want you to try to think about all the things that are happening in the background:

//--@Published published change anouncements automatically.

//--@ObservedObject watches those anouncements and refreshes any views using the object.

//--sheet() watches a condition we speify and shows of hide a view automatically.

//--COdable can convert Swift objects into JSON and back with almost no code from us.

//--UserDefaults can read and write data so that we can save settings and more instantly.

//Yes, we need to write code to put those things in place, but so much boilerplate code has been removed that what remains is quite remarkable. As French writer and poet Antione de Saint-Exupery once said, "perfection is achieved not when there is nothing more to add, but rather when there is nothing more to take away.

//Today you have five topics to work through, in which you'll learn about @ObservedObject, sheet(), onDelete(), and more.

//MARK: Building a List we can Delete from

//MARK: Working with Identifiable items in SwiftUI

//MARK: Sharing an observed object with a new view

//MARK: Making changes permanent with UserDefaults

//MARK: Final Polish
