import SwiftUI

struct MenuScreen: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("99 EduHub")
                        .font(Font.title.weight(.black))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    Image("99")
                        .resizable()
                        .frame(width: 150.0, height: 150.0)
                    
                    Button(action: {}) {
                        NavigationLink(destination: TeacherList()) {
                            Text("Students: Teacher List （教师名单）")
                                .padding(.all, 10)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.bottom)
                        }
                    }
                    
                    Button(action: {}) {
                        NavigationLink(destination: CourseView()) {
                            Text("Students: Course List （课程清单）")
                                .padding(.all, 10)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.bottom)
                        }
                    }
                    
                    Text("Registration Link:")
                        .padding(.bottom)
                    Text("https://forms.gle/ssNuJa9hSpAU4wfU7")
                        .padding(.bottom)
                }
                .padding()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}
