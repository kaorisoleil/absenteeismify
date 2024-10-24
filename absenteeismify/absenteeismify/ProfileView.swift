//
//  NotesView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/31/24.
//

import Foundation
import SwiftUI
import CoreLocationUI


struct ProfileView : View {

    @ObservedObject var locationManager = LocationManager()
    @EnvironmentObject var authViewModel : AuthViewModel
    @EnvironmentObject var scheduleViewModel: ScheduleViewModel
    
    var body: some View {
        
            VStack(spacing: 20) { 
                Spacer() // Add spacing between elements
                ZStack {
                    Circle()
                        .fill(Color("lightblue")) // Background circle
                        .frame(width: 120, height: 120) // Set size for the circle
                    
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100) // Set size for the profile image
                        .foregroundColor(Color("darkblue")) // Icon color
                }
                
                Text("\(scheduleViewModel.student.first_name) \(scheduleViewModel.student.last_name)")
                    .font(.custom("Avenir", size: 26))
                    .fontWeight(.bold)
                    .foregroundColor(Color("darkblue"))
                    .padding(.top)

                Text("\(scheduleViewModel.student.school)")
                    .font(.custom("Avenir", size: 24))
                    .foregroundColor(Color("darkblue"))
                    .padding(.bottom)
                
                Button(action: { authViewModel.signOut() }) {
                    HStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 20)) // Increase icon size
                        Text("Sign out")
                            .font(.custom("Avenir", size: 25))
                            .bold()
                    }
                    .frame(maxWidth: .infinity, minHeight: 50) // Full width button
                    .background(Color("darkblue")) // Button background color
                    .foregroundColor(Color("lightb2")) // Button text color
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Add shadow for depth
                }
                .padding(.top, 20) // Add spacing above the button

                Spacer() // Push content to the top
            }
            .padding() // Overall padding for the VStack
            //.background(Color("lightb2").edgesIgnoringSafeArea(.all)) // Background color for the view
        }
    }
    
    /*
    var body: some View {
        VStack{
            ZStack
            {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .background(Color("lightblue"))
                    .foregroundColor(Color("darkblue"))
            }
            
            Text("\(scheduleViewModel.student.first_name)  \(scheduleViewModel.student.last_name)")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            Text("\(scheduleViewModel.student.school)")
            
            //
            Button(action: { authViewModel.signOut() }) {
    
                HStack { 
                    Image(systemName: "person.fill")
                    Text("Sign out") .font(.headline)
                }
                .frame(width: 280, height: 50)
                .background(Color("darkblue"))
                .foregroundColor(Color("lightblue"))
                .cornerRadius(10) }
          //
            }
        .background(Color("lightb2"))
        /*
            Text("\(String(format: "%.0f", locationManager.degrees))º".uppercased())
                .font(.largeTitle)
            if let myLocation = locationManager.location {
                Text("Latitude: \(myLocation.latitude.formatted(.number.precision(.fractionLength(0)))), Longitude: \(myLocation.longitude.formatted(.number.precision(.fractionLength(0))))".uppercased())
            } else {
                LocationButton {
                    locationManager.requestLocation()
                }
                .labelStyle(.iconOnly)
                .cornerRadius(20)
            }
         */
        }
       
    }
*/
