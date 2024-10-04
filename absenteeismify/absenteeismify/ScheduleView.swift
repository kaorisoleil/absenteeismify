//
//  ScheduleView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/31/24.
//

import Foundation
import SwiftUI

// Model for a class object
struct ClassInfo: Identifiable {
    let id = UUID()         // Unique identifier
    var name: String  
    var teacher: String// Class name
    var emailbody: String
}

struct ScheduleView: View {
    // Array of class objects
    @State private var classes: [ClassInfo] = [
        ClassInfo(name: "AP Statistics", teacher: "Mr. Zopp", emailbody: "Hello teacher I cannot come in today because my sister was sick"),
        ClassInfo(name: "AP U.S. History", teacher: "Mr. Smith", emailbody: "Hello teacher I cannot come in today because I was sick"),
        ClassInfo(name: "Physics", teacher: "Mr. Mesa", emailbody: "Hello teacher I cannot come in today because I was sick")
    ]
    
    var body: some View {
        
        
        ScrollView {  // Add ScrollView to enable scrolling
            VStack(alignment: .leading, spacing: 10) {
                ForEach(classes) { classItem in
                    DisclosureGroup {
                        // Inside the expanded section
                        VStack(alignment: .leading) {
                            Text("Dear Teacher, I was absent...") // Placeholder for email
                                .padding()
                            // Dummy "Send Email" button
                            Button(action: {
                                // Dummy action for now
                                print("Email sent for \(classItem.name)")
                            }) {
                                Text("Send Email")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                    } label: {
                        Text(classItem.name)  // Class name as the label
                            .font(.headline)
                            .padding()
                    }
                    .padding()
                    .background(Color("darkblue")) // Background for each DisclosureGroup
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}
