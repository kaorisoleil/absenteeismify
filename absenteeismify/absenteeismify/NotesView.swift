//
//  NotesView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/31/24.
//

import Foundation
import SwiftUI
import CoreLocationUI


struct NotesView : View {

    @ObservedObject var locationManager = LocationManager()
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
        VStack{
            
            Button(action: { authViewModel.signOut() }) {
    
                HStack { 
                    Image(systemName: "person.fill")
                    Text("Sign out") .font(.headline)
                }
                .frame(width: 280, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10) }
          
            }
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

