//
//  ContentView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var name:String = ""
       @State private var grade:String = ""
       @State private var school:String = ""
      @State private var id: String = ""
   
    var body: some View {
        
        NavigationView{
                   VStack
                   {
                       Spacer()
                       Image(uiImage: UIImage(named: "logo") ?? UIImage(systemName: "logo")!)
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(maxWidth: 95, maxHeight: 95)
                       TextField("Enter your name", text: $name)
                           .padding()
                           .font(.custom("baskerville", size: 16))
                           .foregroundColor(.brown)
                       TextField("Enter grade", text: $grade)
                           .padding()
                           .font(.custom("baskerville", size: 16))
                           .foregroundColor(.brown)
                       TextField("Enter school", text: $school)
                           .padding()
                           .font(.custom("baskerville", size: 16))
                           .foregroundColor(.brown)
                       TextField("Enter your student id", text: $id)
                           .padding()
                           .font(.custom("baskerville", size: 16))
                           .foregroundColor(.brown)
                       NavigationLink(destination:DetailView(name: $name, grade: $grade, school: $school, id: $id)){
                           Text("LET'S GO!")
                               .padding()
                               .font(.custom("baskerville", size: 24))
                               .buttonStyle(.bordered)
                               .foregroundColor(.red)
                               .background(.brown)
                               .cornerRadius(10)
                       }
                       Spacer()

                   }
                   .padding()
               }
        
        
        
        
    }
}
struct DetailView: View {
    @Binding var name: String
    @Binding var grade: String
    @Binding var school: String
    @Binding var id: String
    @State private var pressed: Bool = false
    var body: some View {

        TabView{
            HomeView(name: $name, grade: $grade, school:$school, id: $id)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
            }
            ScheduleView(name: $name, grade: $grade, school: $school, id: $id)
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Schedule")
                }
            NotesView(name: $name, grade: $grade, school: $school, id: $id)
                .tabItem {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    Text("Notes From Teacher")
                }
            TrackerView(name: $name, grade: $grade, school: $school, id: $id)
                .tabItem {
                    Image(systemName: "calendar.circle")
                    Text("Attendance Tracker")
                }
        }
        .padding()
    }

}

#Preview {
    ContentView()
}

