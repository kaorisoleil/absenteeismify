//
//  ScheduleEditView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 10/20/24.
//

import Foundation
import SwiftUI
struct ScheduleEditView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    @EnvironmentObject var scheduleViewModel: ScheduleViewModel
    @State private var courseName: String = ""
    @State private var teacher: String = ""
    @State private var teacherEmail: String = ""
    @State private var selectedDays: [Bool] = Array(repeating: false, count: 5)  // Track selected days
    
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    var body: some View {
        
        ScrollView{
            
            VStack(spacing: 20){
                
                Image(uiImage: UIImage(named: "logo1") ?? UIImage(systemName: "logo1")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 215, maxHeight: 215)
                /*
                HStack{
                    Spacer()
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(Color("lightblue"))
                        .font(.system(size: 27))
                  Text("Hello,")
                       .font(.custom("Avenir", size: 25))
                       .bold()
                    .foregroundColor(Color("darkblue"))
                   Text("\(scheduleViewModel.student.first_name)!")
                      .font(.custom("Avenir", size: 25))
                        .bold()
                    .foregroundColor(Color("lightblue"))
                    Spacer()
                 
                }
                .padding(.top, 20)
      .ignoresSafeArea(.keyboard)
                */
                
                Text("Add a Course")
                    .font(.custom("Avenir", size: 25))
                            .bold()
                            .foregroundColor(Color("darkblue"))
                            .padding(.bottom, 10)
                
                VStack(spacing: 20) {
                                TextField("Course Name", text: $courseName)
                                    .padding()
                                    .foregroundColor(Color("darkblue"))
                                    .font(.custom("Avenir", size: 19))
                                    .background(Color("lightblue").opacity(0.2))
                                    .cornerRadius(12)
                                    .shadow(color: Color("lightblue").opacity(0.3), radius: 5, x: 0, y: 5)

                                TextField("Teacher", text: $teacher)
                                    .padding()
                                    .foregroundColor(Color("darkblue"))
                                    .font(.custom("Avenir", size: 19))
                                    .background(Color("lightblue").opacity(0.2))
                                    .cornerRadius(12)
                                    .shadow(color: Color("lightblue").opacity(0.3), radius: 5, x: 0, y: 5)

                                TextField("Teacher Email", text: $teacherEmail)
                                    .padding()
                                    .foregroundColor(Color("darkblue"))
                                    .font(.custom("Avenir", size: 19))
                                    .background(Color("lightblue").opacity(0.2))
                                    .cornerRadius(12)
                                    .shadow(color: Color("lightblue").opacity(0.3), radius: 5, x: 0, y: 5)
                            }
                            .padding(.horizontal)
                VStack(alignment: .leading, spacing: 15) {
                                Text("Select Days")
                        .font(.custom("Avenir", size: 25))
                        .bold()
                                  //  .font(.headline)
                                  //  .font(.custom("Chalkboard SE", size: 28))

                                    .foregroundColor(Color("darkblue"))
                                    .padding(.bottom, 5)

                                ForEach(0..<daysOfWeek.count, id: \.self) { index in
                                    Toggle(isOn: $selectedDays[index]) {
                                        Text(self.daysOfWeek[index])
                                           // .font(.system(size: 28, weight: .regular, design: .rounded))
                                            .foregroundColor(Color("darkblue"))
                                           .font(.custom("Avenir", size: 18))
                                    }
                                    .toggleStyle(SwitchToggleStyle(tint: Color("lightb2")))
                                    .padding(.vertical, 5)
                                }
                            }
                //SF ROUNDED FONT
                //.font(.system(size: 28, weight: .regular, design: .rounded))

                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 5)
                            .padding(.horizontal)
                            
                           // Spacer()
                  // Pushes the button to the bottom
                    
                    Button(action: addCourse) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(Color("lightb2"))
                            .padding()
                            .background(Color("darkblue"))
                            .clipShape(Circle())
                        
                    }
                    .padding(.bottom, 30)
                    .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 5)
                
            }
            .ignoresSafeArea(.keyboard)  // Prevent keyboard from pushing content
            .padding()
            
            /*
            .padding()
                    .background(Color("lightb2").opacity(0.1))
                    .edgesIgnoringSafeArea(.bottom)
            
                    .overlay(
                                Button(action: addCourse) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(Color("darkblue"))
                                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 3)
                                }
                                .padding()
                                .background(Color("lightb2"))
                                .clipShape(Circle())
                                .shadow(color: Color("darkblue").opacity(0.3), radius: 10, x: 0, y: 5),
                                alignment: .bottomTrailing
                            )
             */
        }
        
        /*
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
                    .bold()
                    .background(Color("darkblue"))
                    .foregroundColor(Color("lightb2"))
                    .cornerRadius(10)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
         */
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

