//
//  MapView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 10/22/24.
//


import Foundation
import SwiftUI
import MapKit
// Struct to hold location data
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
struct MapView: View {
    
    
    // An array of preloaded locations
    @State private var tutoringCenters = [
        Location(name: "Mathnasium", coordinate: CLLocationCoordinate2D(latitude: 40.90125, longitude: -74.00528)),
        Location(name: "Sylvan Learning of Teaneck", coordinate: CLLocationCoordinate2D(latitude: 40.89133, longitude: -74.00429)),
        Location(name: "Kumon Math and Reading Center of Teaneck", coordinate:CLLocationCoordinate2D(latitude: 40.8905, longitude: -74.02607) )
    ]
    
    @State private var freeWifi = [
        Location(name: "Teaneck Public Library", coordinate: CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.985130)),
        Location(name: "Kudo Society", coordinate: CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.985130))
    ]
    
    @State private var printers = [
        Location(name: "Teaneck Public Library", coordinate: CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.985130))
    ]
    
    @State private var selected = "freeWifi"
    
    
    
    // Region to center the map on (New York in this case)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8932, longitude: -73.985130), // Times Square as the center
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // Zoom level
    )
    
    var body: some View {
        VStack{
            Spacer()
            
            Picker("Resources", selection: $selected) {
                Text("Tutoring Centers").tag("tutoringCenters")
                Text("Free Wifi").tag("freeWifi")
                Text("Printers").tag("printers")
            }
            .pickerStyle(.segmented)
            
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .padding()
                
                if selected == "tutoringCenters" {
                    Map(coordinateRegion: $region, annotationItems: tutoringCenters) { location in
                        MapMarker(coordinate: location.coordinate, tint: .red)
                    }
                    .cornerRadius(12)
                }
                else if selected == "freeWifi"{
                    Map(coordinateRegion: $region, annotationItems: freeWifi) { location in
                        MapMarker(coordinate: location.coordinate, tint: .red)
                    }
                    .cornerRadius(12)
                }
                else if selected == "freeWifi"{
                    Map(coordinateRegion: $region, annotationItems: printers) { location in
                        MapMarker(coordinate: location.coordinate, tint: .red)
                    }
                    .cornerRadius(12)
                }
                
            }
            .frame(height:300)
            Spacer()
        }
        .padding(.horizontal)
    }
    
}
