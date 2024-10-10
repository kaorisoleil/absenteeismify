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
    @Published var student: Student? = nil
    //its changable throughout the class and the view
    func fetchCourses() {
        let dow = "Thursday"
       // let dow = getDayOfWeek(from: Date())
      //  print(dow)
        
        if dow == "Monday"{
            self.todayCourses = self.student?.schedule[0] ?? []
        }
        else if dow == "Tuesday"{
            self.todayCourses = self.student?.schedule[1] ?? []
        }
        else if dow == "Wednesday"{
            self.todayCourses = self.student?.schedule[2] ?? []
        }
        else if dow == "Thursday" {
            self.todayCourses = self.student?.schedule[3] ?? []
        }
        else if dow == "Friday" {
            self.todayCourses = self.student?.schedule[4] ?? []
        }
        
        
    }
    
    func setUpDummy() {
        self.student = Student(id: UUID().uuidString, first_name: "Soleil", last_name: "Holmes", school: "Teaneck High School", schedule: [])
        
        var course1 = Course(id: UUID().uuidString, name: "Spanish II", teacher: "A", teacher_email: "soleilkholmes@gmail.com")
        var course2 = Course(id: UUID().uuidString, name: "AP LANG" , teacher: "B", teacher_email: "soleilkholmes@gmail.com")
        var course3 = Course(id: UUID().uuidString, name: "APUSH" , teacher: "C", teacher_email: "soleilkholmes@gmail.com")
        var course4 = Course(id: UUID().uuidString, name: "STUDY", teacher: "D", teacher_email: "soleilkholmes@gmail.com")
        var course5 = Course(id: UUID().uuidString, name: "GYM", teacher: "E" , teacher_email: "soleilkholmes@gmail.com")
        var course6 = Course(id: UUID().uuidString, name: "PHYSICS" , teacher: "F", teacher_email: "soleilkholmes@gmail.com")
        var course7 = Course(id: UUID().uuidString, name: "AP CSP", teacher: "G" , teacher_email: "soleilkholmes@gmail.com")
        
        var schedule = [ [course1, course3, course5, course7], [course2, course4, course6, course7], [course1, course3, course5, course7], [course2, course4, course6, course7], [course1, course3, course5, course7]  ]
        
        self.student?.schedule = schedule
    }
    
    func getDayOfWeek(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
}

