//
//  ScheduleView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/31/24.
//

import Foundation
import SwiftUI

// Model for a class object


struct ScheduleView: View {
    @StateObject private var scheduleViewModel = ScheduleViewModel()
    @EnvironmentObject var authViewModel : AuthViewModel
    @State var emailBody = " "
   
    var body: some View {
        ScrollView {  // Add ScrollView to enable scrolling
           // Text("\(scheduleViewModel.todayCourses)")
            
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(scheduleViewModel.todayCourses) { course in
                    DisclosureGroup {
                        // Inside the expanded section
                        VStack(alignment: .leading) {
            //Turn this into a textfield
                            ScrollView {
                                TextEditor(text: $emailBody)
                                                                .frame(height: 100)  // Set a fixed height
                                                                .padding()
                                                                .overlay(
                                                                    RoundedRectangle(cornerRadius: 8)
                                                                        .stroke(Color("darkblue"), lineWidth: 2)  // Add a gray border
                                                                )
                            }
                           
                            // Dummy "Send Email" button
                            Button(action: {
                                // Dummy action for now
                                scheduleViewModel.sendEmail(token: authViewModel.accessToken, emailbody: emailBody, course: course, useremail: authViewModel.userEmail)
                                
                            }) {
                                Text("Send Email")
                                    .foregroundColor(Color("lightblue"))
                                    .padding()
                                    .bold()
                                    .background(Color("darkblue"))
                                    .cornerRadius(8)
                            }
                        }.onAppear{
                            emailBody = "Dear \(course.teacher), I missed class today because I was sick. How can I make up the work? I am happy to stay afterschool next week to make this work."
                               
                        }
                        .padding()
                        .foregroundColor(Color("darkblue"))
                    } label: {
                        Text(course.name)  // Class name as the label
                            .font(.custom("helvetica", size: 27))
                            .bold()
                            .foregroundColor(Color("darkblue"))
                            .padding()
                    }
                    .padding()
                  .background(Color("lightblue")) // Background for each DisclosureGroup
                    .cornerRadius(10)
                }
            }
            .padding()
        
        } .onAppear{
            scheduleViewModel.setUpDummy()
            scheduleViewModel.fetchCourses()
        }
    }
}
