//
//  CourseView.swift
//  Courses
//
//  Created by Weihang Zheng on 2022-08-21.
//

import SwiftUI

struct CourseView: View {
    var courses = getAllCourses()
    var body: some View {
        NavigationView{
            List(courses, id: \.self){ course in
                NavigationLink {
                    CourseDes(courses: course, depth: 0)
                } label: {
                    Text(course)
                }.navigationTitle("Course List")
            }
        }.navigationViewStyle(DefaultNavigationViewStyle())
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
    }
}
