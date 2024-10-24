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
           ScrollView {
               VStack(alignment: .leading, spacing: 20) {
                   HStack {
                       Spacer()
                       Text(" \(scheduleViewModel.student.first_name)'s Schedule")
                           .font(.custom("Avenir", size: 25))
                           .bold()
                       .foregroundColor(Color("darkblue"))
                       Image(systemName: "books.vertical")
                           .foregroundColor(Color("lightblue"))
                           .font(.system(size: 28))
                       Spacer()
                   }
                  
                   ForEach(scheduleViewModel.todayCourses) { course in
                       DisclosureGroup {
                           // Inside the expanded section
                           VStack(alignment: .leading, spacing: 15) {
                               
                               // Custom-styled Text Editor for email body
                               TextEditor(text: $emailBody)
                                   .frame(height: 100)
                                   .font(.custom("Avenir", size: 14))
                                   .foregroundColor(Color("darkblue"))
                                   .bold()
                                   .padding()
                                   .background(Color.white)  // White background for contrast
                                   .cornerRadius(10)
                                   .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)  // Light shadow
                                   .overlay(
                                       RoundedRectangle(cornerRadius: 10)
                                           .stroke(Color("darkblue"), lineWidth: 2)
                                   )
                               
                               // Send Email Button
                               Button(action: {
                                   // Action for sending email
                                   print("ACCESS TOKEN FROM VIEW: ", authViewModel.accessToken)
                                   scheduleViewModel.sendEmail(
                                       token: authViewModel.accessToken,
                                       emailbody: emailBody,
                                       course: course,
                                       useremail: authViewModel.userEmail
                                   )
                               }) {
                                   HStack {
                                       Image(systemName: "paperplane.fill")
                                       Text("Send Email")
                                           .fontWeight(.bold)
                                           .font(.custom("Avenir", size: 25))
                                           .bold()
                                   }
                                   .padding()
                                   .frame(maxWidth: .infinity)
                                   .background(Color("darkblue"))
                                   .foregroundColor(.white)
                                   .cornerRadius(10)
                                   .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 4)  // Button shadow for depth
                               }
                           }
                           .padding()
                           .background(Color("lightb2"))  // Background for expanded section
                           .cornerRadius(10)
                           .onAppear {
                               // Prefilled email body template
                               emailBody = "Dear \(course.teacher),                                 I hope all is well. I missed both today's class and the quiz because I was sick. How can I make up the work? I am happy to stay afterschool next week to make this work. Best, \(scheduleViewModel.student.first_name) \(scheduleViewModel.student.last_name)"
                           }
                       } label: {
                           // Course title label with improved styling
                           Text(course.name)
                               .font(.custom("Avenir", size: 25))
                               .bold()
                               .foregroundColor(Color("darkblue"))
                       }
                       .padding()
                       .background(Color("lightb2"))  // Card-like background for each course
                       .cornerRadius(12)
                       .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 3)  // Soft shadow
                   }
               }
               .padding()
           }
           .onAppear {
               if let savedAccessToken = UserDefaults.standard.string(forKey: "accessToken") {
                   print("Access Token: \(savedAccessToken)")
                   authViewModel.accessToken = savedAccessToken
               } else {
                   print("No access token found")
               }
               scheduleViewModel.setUp()
               scheduleViewModel.fetchCourses()
           }
       }
   }
    
    /*
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
                                
                                print("ACCESS TOKEN FROM VIEW: ", authViewModel.accessToken)
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
            if let savedAccessToken = UserDefaults.standard.string(forKey: "accessToken")
            {
                print("Access Token: \(savedAccessToken)")
                authViewModel.accessToken = savedAccessToken
            }
            else {
                print("No access token found")
            }
           
            scheduleViewModel.setUp()
            scheduleViewModel.fetchCourses()
        }
    }
}
*/
