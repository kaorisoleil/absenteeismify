//
//  ContentView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        
        NavigationView{
                   VStack
                   {
                       Spacer()
                       Image(uiImage: UIImage(named: "logo1") ?? UIImage(systemName: "logo1")!)
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(maxWidth: 250, maxHeight: 250)
                      
                       NavigationLink(destination: DetailView()) {
                           
                           Text("Sign in with Google")
                               .padding()
                               .font(.custom("baskerville", size: 24))
                               .bold()
                               .buttonStyle(.bordered)
                               .foregroundColor(Color("lightblue"))
                               .background(Color("darkblue"))
                               .cornerRadius(10)
                       }
                       Spacer()

                   }
                   .padding()
               }
        
        
        
        
    }
}
struct DetailView: View {
    var body: some View {

        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
            }
            ScheduleView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Schedule")
                }
            NotesView()
                .tabItem {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    Text("Notes From Teacher")
                }
            TrackerView()
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

