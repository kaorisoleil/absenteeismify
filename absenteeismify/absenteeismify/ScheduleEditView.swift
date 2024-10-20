//
//  ScheduleEditView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 10/20/24.
//

import Foundation
import SwiftUI
struct ScheduleEditView: View {
    
    @State private var courseName: String = ""
    @State private var teacher: String = ""
    @State private var teacherEmail: String = ""
    @State private var selectedDays: [Bool] = Array(repeating: false, count: 5)  // Track selected days
    
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    var body: some View {
        VStack(spacing: 20) {
            TextField("Course Name", text: $courseName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Teacher", text: $teacher)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Teacher Email", text: $teacherEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            // Multiple day selection using Toggle buttons
            VStack(alignment: .leading) {
                Text("Select Days")
                    .font(.headline)
                ForEach(0..<daysOfWeek.count, id: \.self) { index in
                    Toggle(isOn: $selectedDays[index]) {
                        Text(self.daysOfWeek[index])
                    }
                    .padding(.horizontal)
                }
            }
            Button(action: addCourse) {
                Text("Add Course")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
    }
    
    // Add the course to the selected days in the student's schedule
    func addCourse() {
        // Retrieve the student from UserDefaults
        if let data = UserDefaults.standard.data(forKey: "studentData"),
           var student = try? JSONDecoder().decode(Student.self, from: data) {
            
            let newCourse = Course(id: UUID().uuidString, name: courseName, teacher: teacher, teacher_email: teacherEmail)
            
            // Ensure we have exactly 5 arrays, one for each weekday
            if student.schedule.count < 5 {
                student.schedule = Array(repeating: [], count: 5)
            }
            
            // Add the course to all selected days
            for dayIndex in 0..<selectedDays.count where selectedDays[dayIndex] {
                student.schedule[dayIndex].append(newCourse)
            }
            
            // Save the updated student back to UserDefaults
            if let updatedData = try? JSONEncoder().encode(student) {
                UserDefaults.standard.set(updatedData, forKey: "studentData")
                print("Course added to selected days!")
            }
        }
    }
}

