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
            ScrollView {
                VStack {
                    Text(courses)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(Font.title.weight(.black))
                        .multilineTextAlignment(.center)
                    Toggle("中文/English", isOn: $showGreeting)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                    if showGreeting {
                        Text(subject_des[courses]!)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text(subject_des_eng[courses]!)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    if depth < 1 {
                        NavigationView {
                            List(tc[courses]!, id: \.self) { teacher in
                                NavigationLink {
                                    TeacherDes(teacher: teacher, depth: depth + 1)
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
}
