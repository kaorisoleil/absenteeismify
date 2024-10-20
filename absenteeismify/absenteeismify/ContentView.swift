//
//  ContentView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/24/24.
//

import SwiftUI
import SwiftData
import GoogleSignIn
import FirebaseAuth
import FirebaseCore



struct ContentView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        NavigationView{
            if !authViewModel.isSignedIn{
                VStack
                {
                    Spacer()
                    Image(uiImage: UIImage(named: "logo1") ?? UIImage(systemName: "logo1")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 250, maxHeight: 250)
                   
                    NavigationLink(destination: PresenceCheckView()) {
                        
                        Button(action: { authViewModel.signInWithGoogle() })
                        {
                            HStack { Image(systemName: "person.fill")
                                Text("Sign in with Google") .font(.headline)
                            }
                            .frame(width: 280, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10) }
                      
                    }
                    Spacer()

                }
                .padding()
            }
            else
            {
                PresenceCheckView()
            }
                  
               }
        
        
        
        
    }
    
}

struct PresenceCheckView: View {
    @State private var isAbsent = false
    @State private var showingDetailView = false  // To navigate to the detail view after presence check
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Are you here today?")
                .font(.title)
                .bold()
                .padding()

            Button(action: {
                isAbsent = true
                showingDetailView = true
            }) {
                Text("I am Absent")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }

            Button(action: {
                isAbsent = false
                showingDetailView = true
            }) {
                Text("I am Present")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
        .fullScreenCover(isPresented: $showingDetailView) {
            if isAbsent {
                ScheduleView()  // If absent, go to ScheduleView to generate emails
            } else {
                DetailView()    // If present, go to the main tab view (DetailView)
            }
        }
        .padding()
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

