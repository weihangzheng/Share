//
//  TeacherDes.swift
//  Course
//
//  Created by Weihang Zheng on 2023-04-15.
//

import SwiftUI

struct TeacherDes: View {
    @State private var showGreeting = true
    var teacher: String
    var tc = getTeacherClasses()
    var teacher_des = getTeacherDes()
    var teacher_des_eng = getTeacherDesEng()
    var body: some View {
        VStack{
        Toggle("中文/English", isOn: $showGreeting)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
        if showGreeting {
            Text(teacher_des[teacher]!)
        }else{
            Text(teacher_des_eng[teacher]!)
        }
        NavigationView{
            List(tc[teacher]!, id: \.self){ subject in
                NavigationLink {
                    CourseDes(courses: subject)
                } label: {
                    Text(subject)
                }.navigationTitle("Subject List")
            }
        }.navigationViewStyle(DefaultNavigationViewStyle())
        .navigationTitle(teacher)
        }
    }
}

