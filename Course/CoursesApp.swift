//
//  CoursesApp.swift
//  Courses
//
//  Created by Weihang Zheng on 2022-07-18.
//

import SwiftUI
import Firebase

@main
struct CoursesApp: App {
    init() {
            FirebaseApp.configure()
            Database.database().isPersistenceEnabled = true


        }
    var body: some Scene {
        WindowGroup {
            MenuScreen()
        }
    }
}
