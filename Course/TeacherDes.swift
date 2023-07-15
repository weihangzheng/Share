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
    var depth : Int
    var tc = getTeacherClasses()
    var teacher_des = getTeacherDes()
    var teacher_des_eng = getTeacherDesEng()
    var body: some View {
        if depth < 2 {
            VStack{
                Text(teacher).frame(maxWidth: .infinity, alignment:.center).font(Font.title.weight(.black)).multilineTextAlignment(.center)
                Toggle("中文/English", isOn: $showGreeting)
                    .toggleStyle(SwitchToggleStyle(tint: .red))
                if showGreeting {
                    Text(teacher_des[teacher]!)
                }else{
                    Text(teacher_des_eng[teacher]!)
                }
                if depth < 1 {
                    NavigationView{
                        List(tc[teacher]!, id: \.self){ subject in
                            NavigationLink {
                                CourseDes(courses: subject, depth: depth+1)
                            } label: {
                                Text(subject)
                            }.navigationTitle("Subject List")
                        }
                    }.navigationViewStyle(DefaultNavigationViewStyle())
                }
            }
        }
    }
}

