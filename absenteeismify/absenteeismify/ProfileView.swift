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
        VStack{
            ZStack
            {
                Circle()
                    .frame(maxWidth: 100, maxHeight: 100)
                Image(systemName: "person.fill")
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

