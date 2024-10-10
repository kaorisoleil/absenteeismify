//
//  AllModels.swift
//  absenteeismify
//
//  Created by Guest Soleil on 10/6/24.
//

import Foundation

struct Student: Codable {
  var id: String
    var first_name: String
    var last_name: String
    var school: String
    var schedule: [[Course]]
    
}
//eventually account for attendence history 
struct Course: Codable, Identifiable{
    var id: String
    var name: String
    var teacher: String
    var teacher_email: String
}
