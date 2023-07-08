//
//  CourseDes.swift
//  Course
//
//  Created by Weihang Zheng on 2023-04-15.
//

import SwiftUI

struct CourseDes: View {
    @State private var showGreeting = true
    var courses : String
    var tc = getCourseTeachers()
    var subject_des = getSubjectDes()
    var subject_des_eng = getSubjectDesEng()
    var body: some View {
        VStack{
        Toggle("中文/English", isOn: $showGreeting)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
        if showGreeting {
            Text(subject_des[courses]!)
        }else{
            Text(subject_des_eng[courses]!)
        }
        NavigationView{
            List(tc[courses]!, id: \.self){ teacher in
                NavigationLink {
                    TeacherDes(teacher: teacher)
                } label: {
                    Text(teacher)
                }.navigationTitle("Teacher List")
            }
        }.navigationViewStyle(DefaultNavigationViewStyle())
        .navigationTitle(courses)
        }
    }
}

