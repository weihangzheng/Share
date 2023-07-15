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
    var depth : Int
    var tc = getCourseTeachers()
    var subject_des = getSubjectDes()
    var subject_des_eng = getSubjectDesEng()
    var body: some View {
        if depth < 2 {
            VStack{
                Text(courses).frame(maxWidth: .infinity, alignment:.center).font(Font.title.weight(.black)).multilineTextAlignment(.center)
                Toggle("中文/English", isOn: $showGreeting)
                    .toggleStyle(SwitchToggleStyle(tint: .red))
                if showGreeting {
                    Text(subject_des[courses]!)
                }else{
                    Text(subject_des_eng[courses]!)
                }
                if depth < 1 {
                    NavigationView{
                        List(tc[courses]!, id: \.self){ teacher in
                            NavigationLink {
                                TeacherDes(teacher: teacher, depth:depth+1)
                            } label: {
                                Text(teacher)
                            }.navigationTitle("Teacher List")
                        }
                    }.navigationViewStyle(DefaultNavigationViewStyle())
                }
            }
        }
    }
}

