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
    @EnvironmentObject var scheduleViewModel : ScheduleViewModel
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var school: String = ""
    

    var body: some View {
        
        NavigationView{
            if !authViewModel.isSignedIn{
                VStack(spacing: 20)
                {
                    Spacer()
                    Image(uiImage: UIImage(named: "logo1") ?? UIImage(systemName: "logo1")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 280, maxHeight: 280)
                   
                    VStack {
                        TextField("First Name", text: $firstName)
                            .padding()
                                    .background(Color("lightblue").opacity(0.3)) // Light background for contrast
                                    .cornerRadius(10)
                                    .font(.custom("Avenir", size: 16))
                                   // Custom font size
                                    .foregroundColor(Color("darkblue")) // Text color
                                    .padding(.horizontal)
                                    //   .textFieldStyle(RoundedBorderTextFieldStyle())
                                     //  .padding()
                        TextField("Last Name", text: $lastName)
                            .padding()
                                    .background(Color("lightblue").opacity(0.3)) // Light background for contrast
                                    .cornerRadius(10)
                                    .font(.custom("Avenir", size: 16)) // Custom font size
                                    .foregroundColor(Color("darkblue")) // Text color
                                    .padding(.horizontal)
                                   
                        TextField("School", text: $school)
                            .padding()
                                    .background(Color("lightblue").opacity(0.3)) // Light background for contrast
                                    .cornerRadius(10)
                                    .font(.custom("Avenir", size: 16)) // Custom font size
                                    .foregroundColor(Color("darkblue")) // Text color
                                    .padding(.horizontal)
                    }
                  
                        
                       
                        Button(action: {
                            saveUserInfo()
                            authViewModel.signInWithGoogle()
                        })
                        {
                            HStack { 
                                Image(systemName: "person.fill")
                                    .font(.system(size: 20))
                                Text("Sign in with Google")
                                    .font(.custom("Avenir", size: 20))
                            }
                            .frame(maxWidth: .infinity, minHeight: 50)
                            //.frame(width: 280, height: 50)
                            .background(Color("darkblue")) // Button background color
                                   .foregroundColor(Color("lightb2")) // Button text color
                                   .cornerRadius(10)
                                   .padding(.horizontal) // Horizontal padding for button
                                   .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
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
    func saveUserInfo() {
            let student = Student(id: UUID().uuidString, first_name: firstName, last_name: lastName, school: school, schedule: [[], [], [], [],[] ])
            
            if let encodedData = try? JSONEncoder().encode(student) {
                UserDefaults.standard.set(encodedData, forKey: "studentData")
                print("User info saved!")
            }
        }

    
}
import SwiftUI

struct PresenceCheckView: View {
    @State private var isAbsent = false
    @State private var showingDetailView = false  // To navigate to the detail view after presence check
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Are you here today?")
                .font(.custom("Avenir", size: 25))
                .bold()
                .padding()

            Button(action: {
                isAbsent = true
                showingDetailView = true
            }) {
                Text("I am Absent")
                    .foregroundColor(.white)
                    .padding()
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
                    .font(.custom("Avenir", size: 20))
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
                    .font(.custom("Avenir", size: 20))
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5) 
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
            ScheduleEditView()
                .tabItem {
                    Image(systemName: "house")
                        .foregroundColor(Color("darkblue"))
                    Text("Home")
            }
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar")
                        .foregroundColor(Color("darkblue"))
                    Text("Schedule")
                }
            MapView()
                .tabItem {
                    Image(systemName: "globe.desk")
                        .foregroundColor(Color("darkblue"))
                    Text("Resources")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                        .foregroundColor(Color("darkblue"))
                    Text("Profile")
                }
        }
        .padding()
        
    }

}

#Preview {
    ContentView()
}

