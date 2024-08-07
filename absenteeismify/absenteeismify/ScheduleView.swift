//
//  ScheduleView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/31/24.
//

import Foundation
import SwiftUI
struct ScheduleView: View {

    @Binding var name: String
    @Binding var grade: String
    @Binding var school: String
    @Binding var id: String

    var body: some View {
        VStack{
            Text("Hello , \(name)!")
                .font(.custom("baskerville", size: 24))
                .padding()

        }
    }
}
