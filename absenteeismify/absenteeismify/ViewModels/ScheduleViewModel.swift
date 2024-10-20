//
//  ScheduleViewModel.swift
//  absenteeismify
//
//  Created by Guest Soleil on 10/6/24.
//

import Foundation
import SwiftUI
import Combine
//observable object identifier allows other views to acess the class
class ScheduleViewModel: ObservableObject {
    @Published var todayCourses: [Course] = []
    @Published var student: Student
    //its changable throughout the class and the view
    init() {
        
            self.student = Student( id: UUID().uuidString, first_name: "Default", last_name: "Student", school: "Default School", schedule: Array(repeating: [], count: 5))
            setUp()
       
    }
    
    func fetchCourses() {
        let dow = "Thursday"
       // let dow = getDayOfWeek(from: Date())
      //  print(dow)
        
        if dow == "Monday"{
            self.todayCourses = self.student.schedule[0]
        }
        else if dow == "Tuesday"{
            self.todayCourses = self.student.schedule[1]
        }
        else if dow == "Wednesday"{
            self.todayCourses = self.student.schedule[2]
        }
        else if dow == "Thursday" {
            self.todayCourses = self.student.schedule[3]
        }
        else if dow == "Friday" {
            self.todayCourses = self.student.schedule[4]
        }
        
        
    }
    
    func setUp() {
        
        if let student = getStudentFromUserDefaults()
        {
            self.student = student
            print(self.student)
        }
        else
        {
            return
        }
        
    }
    
    func getDayOfWeek(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func sendEmail(token: String, emailbody: String, course: Course, useremail: String) {
        let url = URL(string: "https://www.googleapis.com/gmail/v1/users/me/messages/send")!
        
    // Create raw email content
    let rawMessage = """
    From: \(useremail)
    To: \(course.teacher_email)
    Subject: Absence, Catchup Request
    
    \(emailbody)
    """.data(using: .utf8)!.base64EncodedString()
    
    let parameters = ["raw": rawMessage]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = data
    } catch {
        print("Error serializing JSON: \(error.localizedDescription)")
        return
    }
    
    // Send the email
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error sending email: \(error.localizedDescription)")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("Email sent successfully!")
        } else {
            print("Failed to send email. Status code: \(response)")
        }
    }
    
    task.resume()
            

    }
    
    
    func getStudentFromUserDefaults() -> Student? {
        if let data = UserDefaults.standard.data(forKey: "studentData") {
            do {
                let student = try JSONDecoder().decode(Student.self, from: data)
                return student
            } catch {
                print("Error decoding student data: \(error.localizedDescription)")
                return nil
            }
        } else {
            print("No student data found in UserDefaults.")
            return nil
        }
    }

    
}

