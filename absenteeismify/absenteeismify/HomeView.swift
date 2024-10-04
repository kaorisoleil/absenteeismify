//
//  HomeView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/31/24.
//

import Foundation
import SwiftUI
import Charts

struct Class: Identifiable {
    let id = UUID()
    let name: String
}

struct HomeView: View {
    /*
    let classes = [
        Class(name: "BIOLOGY \n RM 211\n8:38 - 9:24 AM"),
        Class(name: "ALGEBRA 2 \n RM 234 \n 9:30 AM - 11:15 AM"),
        Class(name: "AP U.S. HISTORY \n RM 205 \n 11:20 AM - 1:05 PM")

    ]
 
    struct ExerciseData: Identifiable, Equatable {
        var category: String
        var amount: Double
        var color: Color
        var id = UUID()
    }
    let totalHours: [ExerciseData] = [
        .init(category: "Cardio", amount: 2.4, color: Color.pink),
        .init(category: "Weights", amount: 5.5, color:h Color.yellow),
        .init(category: "HIIT", amount:4.7, color: Color.brown),
        .init(category: "Low Intensity", amount: 4.0, color: Color.cyan)
    ]
    */
    var body: some View {

           VStack{

               NavigationView {
                   VStack{
                       HStack{
                           ZStack
                           {
                               Circle()
                                   .fill(Color.black)
                                   .frame(width:50, height:50)
                               Image(systemName: "person.fill")
                                   .resizable()
                                .foregroundColor(.white)
                                   .frame(width: 30, height: 30)
                           }


                           Text("Hello!")
                               .font(.custom("baskerville", size: 24))
                               .padding()
                       }

                       NavigationLink(destination: TrackerView()) {
                           HStack{
                               Image(systemName: "checkmark.circle.fill")
                                   .foregroundColor(.green)
                               Text("Present")
                                   .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                   .foregroundColor(.mint)
                           }
                           .padding()
                           .background(Color.green.opacity(0.2))
                           .cornerRadius(10)
                       }
                       HStack
                       {
                           // gc button
                           VStack{
                               Button (action: {
                                   if let url = URL(string: "https://classroom.google.com"){
                                       UIApplication.shared.open(url)
                                   }
                               }) {
                                   Image("gclogo")
                                       .resizable()
                                       .scaledToFit()
                                       .frame(width: 100, height: 100)
                                       .foregroundColor(.gray)
                                       .clipShape(RoundedRectangle(cornerRadius: 10))
                               }

                           }
                           // notes from teacher button
                             NavigationLink(destination: NotesView()) {
                                 VStack
                                 {
                                     Image(systemName: "envelope.circle")
                                     Text("NOTE(S) FROM THE TEACHER")
                                     .font(.system(size: 10))
                                 }
                                 .padding()
                                  .background(Color.gray)
                                 .frame(width: 100, height: 100)
                                 .cornerRadius(13)


                             }
                       }

                       HStack {
                           Image(systemName: "arrow.left")
                               .font(.system(size: 30))
                           Text("TODAY'S CLASSES")
                               .font(.custom("baskerville", size: 24))
                               .padding()
                       }

                       // scroll
                       ZStack {
                           //background drop
                           /*
                           RoundedRectangle(cornerRadius:20)
                               .fill(Color(.darkGray))
                               .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height - 200)
                               .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            */
                        
                           ScrollView {
                               VStack(alignment: .leading, spacing: 10) {
                               //    ForEach(classes){
                                   //    classItem in
                                    //   Text(classItem.name)
                                         //  .font(.headline)
                                          // .padding()
                                          // .frame(maxWidth: .infinity, maxHeight: 100)
                                         //  .background(Color(.systemGray6))
                                         //  .cornerRadius(10)
                                         //  .shadow(radius: 2)
                                        //   .padding(.horizontal)
                                        //   .multilineTextAlignment(.center)
                                   }
                               }
                            //   .padding(.vertical)
                           }
                           /*
                           .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 220)
                            */
                       }


                   }

               }


         }

       /*
        VStack {

            GroupBox("STATS")
            {
                Chart(totalHours){
                    SectorMark(
                        angle: .value("Amount", $0.amount),
                        innerRadius: .ratio(0.6), // gap in the center
                        angularInset: 3.0 // space between each section
                    )
                    .cornerRadius(6.0)
                    .foregroundStyle($0.color)
                }
                HStack
                {
                    ForEach(totalHours) { item in
                        HStack {
                            Circle()
                                .fill(item.color)
                                .frame(width: 10, height: 10)
                            Text(item.category)
                                .foregroundColor(item.color)
                        }

                    }
                }
            }
            .frame(height: 500)
        }
        .padding()
        */
    }




