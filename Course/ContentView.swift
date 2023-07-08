//
//  TeacherList.swift
//  Courses
//
//  Created by Weihang Zheng on 2022-07-18.
//
import SwiftUI

struct TeacherList: View {
    var teachers = getAllTeachers()
    var body: some View {
        NavigationView{
            List(teachers, id: \.self){ teacher in
                NavigationLink {
                    TeacherDes(teacher: teacher)
                } label: {
                    Text(teacher)
                }.navigationTitle("Teacher List")
            }
        }.navigationViewStyle(DefaultNavigationViewStyle())
    }
}

struct TeacherList_Previews: PreviewProvider {
    static var previews: some View {
        TeacherList()
    }
}
