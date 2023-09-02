import SwiftUI
import Firebase
import FirebaseDatabase


struct MenuScreen: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loginErrorMessage: String? = nil
    @State private var loggedInUser: String? = nil
    @State private var users: [String: String] = ["admin": "adminpassword"]
    @State private var registrationUsername = ""
    @State private var secretPassword = ""
    @State private var newGeneratedPassword: String? = nil
    let registrationSecret = "secret"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("99 EduHub").font(Font.title.weight(.black)).multilineTextAlignment(.center).padding(.bottom)
                    Image("99").resizable().frame(width: 150.0, height: 150.0)
                    
                    Group {
                        TextField("Username", text: $username).padding(.all, 10).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.bottom)
                        SecureField("Password", text: $password).padding(.all, 10).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.bottom)
                        
                        // Display login error message
                        if let message = loginErrorMessage {
                            Text(message).foregroundColor(.red)
                        }
                        
                        Button("Login") {
                            authenticateUser(username: username, password: password)
                        }
                        .padding(.all, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    if let user = loggedInUser {
                        if user.lowercased() == "admin" {
                            NavigationLink(destination: AdminView(users: Array(users.keys))) {
                                Text("Admin View").padding(.bottom)
                            }
                        } else {
                            NavigationLink(destination: UserView(username: user)) {
                                Text("Welcome \(user)").padding(.bottom)
                            }
                        }
                    }
                    
                    Group {
                        TextField("New username", text: $registrationUsername).padding(.all, 10).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.bottom)
                        SecureField("Secret password", text: $secretPassword).padding(.all, 10).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.bottom)
                        Button("Register") {
                            registerUser(username: registrationUsername, secretPassword: secretPassword)
                        }
                        .padding(.all, 10)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        if let newPass = newGeneratedPassword {
                            Text("Your new password is \(newPass)").foregroundColor(.red).padding(.bottom)
                                .onTapGesture {
                                    UIPasteboard.general.string = newPass
                                }
                        }
                    }
                    
                    Button(action: {}) {
                        NavigationLink(destination: TeacherList()) {
                            Text("Students: Teacher List （教师名单）").padding(.all, 10).background(Color.green).foregroundColor(.white).cornerRadius(10).padding(.bottom)
                        }
                    }
                    
                    Button(action: {}) {
                        NavigationLink(destination: CourseView()) {
                            Text("Students: Course List （课程清单）").padding(.all, 10).background(Color.green).foregroundColor(.white).cornerRadius(10).padding(.bottom)
                        }
                    }
                    
                    Text("Registration Link:").padding(.bottom)
                    Text("https://forms.gle/ssNuJa9hSpAU4wfU7").padding(.bottom)
                }
                .padding()
                .onAppear {
                        let ref = Database.database().reference().child("users")
                        ref.observe(.value) { snapshot in
                            if let storedUsers = snapshot.value as? [String: String] {
                                self.users = storedUsers
                            }
                        }
                    }
            }
        }
    }
    
    func authenticateUser(username: String, password: String) {
            let ref = Database.database().reference().child("users").child(username)
            ref.observe(.value) { snapshot in
                if let storedPassword = snapshot.value as? String {
                    if storedPassword == password {
                        loggedInUser = username
                        loginErrorMessage = nil
                    } else {
                        loginErrorMessage = "Incorrect password"
                    }
                } else {
                    loginErrorMessage = "Username not found"
                }
            }
        }
    
    func registerUser(username: String, secretPassword: String) {
            if secretPassword == registrationSecret && !username.isEmpty {
                let generatedPassword = randomString(length: 3)
                let ref = Database.database().reference().child("users")
                ref.child(username).setValue(generatedPassword)
                newGeneratedPassword = generatedPassword
            }
        }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

// Rest of your code...


struct UserView: View {
    var username: String
    @State var notes: [TimeNote] = []
    @State var newNoteContent: String = ""
    @State var newNoteStartDate: Date = Date()
    @State var newNoteEndDate: Date = Date().addingTimeInterval(3600) // Start with an hour from now by default
    
    var body: some View {
        VStack {
            Text("Hello \(username)").padding(.bottom)
            
            VStack {
                TextField("New note", text: $newNoteContent).padding(.bottom)
                DatePicker("Start Time", selection: $newNoteStartDate, displayedComponents: [.date, .hourAndMinute]).padding(.bottom)
                DatePicker("End Time", selection: $newNoteEndDate, displayedComponents: [.date, .hourAndMinute]).padding(.bottom)
                
                Button("Add Note") {
                    let newNote = TimeNote(content: newNoteContent, startDate: newNoteStartDate, endDate: newNoteEndDate)
                    notes.append(newNote)
                    newNoteContent = ""
                    newNoteStartDate = Date()
                    newNoteEndDate = Date().addingTimeInterval(3600)
                    saveNotes()
                }
                .padding(.all, 10)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            List {
                ForEach(notes.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(notes[index].content)
                            Text("Date: \(notes[index].dateAndTimeRange)")
                        }
                        Spacer()
                        Button("Delete") {
                            notes.remove(at: index)
                            saveNotes()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                    }
                }
            }

        }
        .onAppear {
                let ref = Database.database().reference().child("notes").child(username)
                ref.observe(.value) { snapshot in
                    let decoder = JSONDecoder()
                    if let data = snapshot.value as? String, let decodedData = Data(base64Encoded: data), let loadedNotes = try? decoder.decode([TimeNote].self, from: decodedData) {
                        self.notes = loadedNotes
                    }
                }
            }
    }
    
    func saveNotes() {
            if let encoded = try? JSONEncoder().encode(notes) {
                let ref = Database.database().reference().child("notes").child(username)
                ref.setValue(encoded.base64EncodedString())
            }
        }

    
    func dateTimeFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}


struct AdminView: View {
    @State var users: [String] = []
    
    func deleteUser(username: String) {
        let ref = Database.database().reference().child("users").child(username)
        ref.removeValue() { error, _ in
            if let error = error {
                print("Error deleting user: \(error)")
            } else {
                // Remove from the local list
                if let index = users.firstIndex(of: username) {
                    users.remove(at: index)
                }
            }
        }
    }

    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                if user.lowercased() != "admin" {
                    NavigationLink(destination: AdminUserView(username: user)) {
                        Text(user)
                    }
                    .contextMenu { // Use context menu for better UX
                        Button(action: {
                            deleteUser(username: user)
                        }) {
                            Text("Delete User")
                            Image(systemName: "trash")
                        }
                    }
                }
            }

            .onAppear(perform: loadUsers)
        }

    }
    
    func loadUsers() {
        let ref = Database.database().reference().child("users")
        ref.observe(.value) { snapshot in
            if let storedUsers = snapshot.value as? [String: String] {
                self.users = Array(storedUsers.keys)
            }
        }
    }

}



struct AdminUserView: View {
    var username: String
    @State var notes: [TimeNote] = []
    
    var body: some View {
        VStack {
            Text("\(username)'s notes")
            
            List {
                ForEach(notes.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(notes[index].content)
                            Text("Date: \(notes[index].dateAndTimeRange)")
                        }
                        Spacer()
                        Button("Delete") {
                            notes.remove(at: index)
                            saveNotes()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                    }
                }
            }
        }
        .onAppear {
            loadNotes()
        }
    }

    func loadNotes() {
            let ref = Database.database().reference().child("notes").child(username)
            ref.observe(.value) { snapshot in
                let decoder = JSONDecoder()
                if let data = snapshot.value as? String, let decodedData = Data(base64Encoded: data), let loadedNotes = try? decoder.decode([TimeNote].self, from: decodedData) {
                    self.notes = loadedNotes
                }
            }
        }

        func saveNotes() {
            if let encoded = try? JSONEncoder().encode(notes) {
                let ref = Database.database().reference().child("notes").child(username)
                ref.setValue(encoded.base64EncodedString())
            }
        }

}

struct TimeNote: Codable, Identifiable {
    let id = UUID()
    var content: String
    var startDate: Date
    var endDate: Date

    var dateAndTimeRange: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
    }

    init(content: String, startDate: Date, endDate: Date) {
        self.content = content
        self.startDate = startDate
        self.endDate = endDate
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}
