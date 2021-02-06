//
//  Sharing SwiftUI state with @ObservableObject.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/6/21.
//

import Foundation


//If you want to use a class with your SwiftUI data - which you will want to do if that data should be shared across more than one view - then SwiftUI gives us two property wrappers that are useful: @ObservedObeject and @EnvironmentObject. We'll be looking at environment object later on, but for now, let's focus on observed objects.

//Here's some code that creates a User class, and shows that user data in a view:
