//
//  Day One Notes.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/6/21.
//

import Foundation


//MARK: Day 36

//Project 7, Part One

//Linus Torvalds, the creator of the open source Linux operating system, was once asked if he had any advice for developers who wanted to build a large software project. Here is the response he gave:

//Nobody should start to undertake a large project. You should start with a small trivial project, and you should never expect it to get large. If you do, you'll just overdesign and generally thing it is more important that it likely is at that stage. Or wrose, you might be scared away by the sheer size of the work you envision.

//In writing this course, I've already had people emailing me adking "why didn't I use X to solve a problem in project 1?" or "Y would have been much better than Z in project 4." They are probably right, but if I tried to teach you everythin in project 1 you'd have found it overwhelming and unpleasant, so instead we build a small app. Then in project 2 we built a second small app. Then we built a third and a fourth, with each one ading to your skills.

//Today you'll start project 7, which is still most definitely a small app. However, in the process you'll learn how to show another screen, how to share data across screens, how to load and save user data, and more - the kinds of features that really help take your SwiftUI skills to the next level.

//If you're all set, let's get to it!

//Today you have seven topics to work through, in which you'll learn about @ObservableObject, sheet(), onDelet(), and more.

//MARK: 1. iExpense Introduction

//Our next two projects are going to start pushing your SwiftUI skills beyond the basics, as we explore apps that have multiple screens, that load and save user data, and have more complex user interfaces.

//In this project we're going to build iExpense, which is an expense tracker that separates personal costs from business costs. At its core this is an app with a form (how much did you spend?) and a list (here are the amounts you spend), but in order to acccomplish these two things you're oging to need to learn how to:

// 1. Present and dismiss a second screen of data

// 2. Delete rows from a list

// 3. Save and load user data

//...and more!

//There's lots to do, so let's get started: create a new iOS app using the Single View App template, naming it iExpense" We'll b using that for the main project, but first lets take a closer look at the new techniques required for the project.




//MARK: 2. Why @State Only Works with Structs

//MARK: 3. Sharing SwiftUI State with @ObervedObject

//MARK: 4. Showing and Hiding Views

//MARK: 5. Deleting Items Using onDelete()

//MARK: 6. Storing User Settings with UserDefaults

//MARK: 7. Archiving Swift Objects with Codable
