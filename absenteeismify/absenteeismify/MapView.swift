//
//  MapView.swift
//  absenteeismify
//
//  Created by Guest Soleil on 10/22/24.
//


//import Foundation
import SwiftUI
import MapKit

struct Location: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let address: String
    let hours: String
    let desc: String
    let coordinate: CLLocationCoordinate2D
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}

struct MapView: View {
    
    @State private var tutoringCenters = [
        Location(name: "Mathnasium", address: "1374 Queen Anne Rd, Teaneck, NJ 07666", hours: "12:30-8 PM", desc: "Uses modern techniques and methods tailored to learning style and needs", coordinate: CLLocationCoordinate2D(latitude: 40.90125, longitude: -74.00528)),
        Location(name: "Sylvan Learning of Teaneck", address: "1086 Teaneck Rd, Teaneck, NJ 07666", hours: "10AM-8PM", desc: "Offers K-12 tutoring, college and career readiness and test prep", coordinate: CLLocationCoordinate2D(latitude: 40.89133, longitude: -74.00429)),
        Location(name: "Kumon Math and Reading Center of Teaneck", address: "570 Cedar Ln, Teaneck, NJ 07666", hours: "10AM-7PM", desc: "Offers tutoring in math and reading using an individualized learning method where students learn at their own pace", coordinate: CLLocationCoordinate2D(latitude: 40.8905, longitude: -74.02607))
    ]
    
    @State private var freeWifi = [
        Location(name: "Teaneck Public Library", address: "840 Teaneck Rd, Teaneck, NJ 07666", hours: "9AM-9PM", desc: "The Teaneck Public Library is a community hub that offers a wide range of modern resources and services for people of all ages. Offers a safe and quiet study space with complimentary high-speed Wi-Fi.", coordinate: CLLocationCoordinate2D(latitude: 40.88591, longitude: -74.0067)),
        Location(name: "Kudo Society", address: "336 Queen Anne Rd, Teaneck, NJ 07666", hours: "8AM-10PM", desc: "Offers a quiet study space with the option of coffees, teas, and bubble teas plus pastries, cookies, and other snacks", coordinate: CLLocationCoordinate2D(latitude: 40.87501, longitude: -74.02081)),
        Location(name: "Barnes & Noble Booksellers", address: "390 Hackensack Ave, Hackensack, NJ 07601", hours: "9AM-9PM", desc: "Offers an inviting study space with comfortable seating, a quiet ambiance, and free Wi-Fi", coordinate: CLLocationCoordinate2D(latitude: 40.90434, longitude: -74.03101))
    ]
    
    @State private var printers = [
        Location(name: "Teaneck Public Library", address: "840 Teaneck Rd, Teaneck, NJ 07666", hours: "9AM-9PM", desc: "The Teaneck Public Library is a community hub that offers a wide range of modern resources and services as well as printing all types of documents for people of all ages.", coordinate: CLLocationCoordinate2D(latitude: 40.88591, longitude: -74.0067)),
        Location(name: "Walgreens", address: "1400 Teaneck Rd, Teaneck, NJ 07666", hours: "7AM-11PM", desc: "Offers convenient printing services in a friendly environment and the ability to print photos, documents, etc. quickly and affordably", coordinate: CLLocationCoordinate2D(latitude: 40.90009, longitude: -74.00064)),
        Location(name: "Staples", address: "25 W Central Ave, Bergenfield, NJ 07621", hours: "8AM-9PM", desc: "Offers a reliable and efficient printing service in a professional setting where you can easily print, copy, and scan documents", coordinate: CLLocationCoordinate2D(latitude: 40.93373, longitude: -73.99655))
    ]
    
    @State private var selected = "freeWifi"
    @State private var highlightedLocation: Location?
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8932, longitude: -73.985130),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("Resources")
                    .font(.custom("Avenir", size: 29))
                    .bold()
                    .foregroundColor(Color("darkblue"))
                    .padding(.bottom, 10)
                Spacer()
            }
            
            Picker("Resources", selection: $selected) {
                Text("Tutoring Centers").tag("tutoringCenters")
                Text("Free Wifi").tag("freeWifi")
                Text("Printers").tag("printers")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .padding()
                
                Map(coordinateRegion: $region, annotationItems: getCurrentLocations()) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Button(action: {
                            highlightedLocation = location
                        }) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(highlightedLocation == location ? Color("lightb2") : Color("darkblue")) // Change color based on selection
                        }
                    }
                }
                .cornerRadius(12)
            }
            .frame(height: 300)
            
            // Scroll View for listing all locations
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(getCurrentLocations()) { location in
                        HStack {
                            Image(uiImage: UIImage(named: location.name) ?? UIImage(systemName: "photo")!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill) // Fill the entire frame
                                    .frame(width: 100, height: 100) // Fixed size for all images
                                    .clipShape(RoundedRectangle(cornerRadius: 10)) // Clip to a cute rounded rectangle
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("darkblue"), lineWidth: 3) // Cute blue border
                                    )
                            
                            VStack(alignment: .leading) {
                                Text("📍 \(location.name)")
                                    .font(.custom("Avenir", size: 16))
                                    .bold()
                                    .foregroundColor((Color("darkblue")))
                                Text("\(location.address)")
                                    .font(.custom("Avenir", size: 14))
                                    .foregroundColor((Color("darkblue")))
                                Text("🕒 \(location.hours)")
                                    .font(.custom("Avenir", size: 14))
                                    .foregroundColor((Color("darkblue")))
                                
                                // Scrollable text view for description
                                ScrollView {
                                    Text("ℹ️ \(location.desc)")
                                        .font(.custom("Avenir", size: 14))
                                        .foregroundColor((Color("darkblue")))
                                        .frame(maxHeight: .infinity) // Expand to fit content
                                        .padding(.vertical, 5) // Add vertical padding
                                }
                                .frame(height: 50) // Fixed height for scrollable area
                                .padding(.top, 5)
                            }
                            .padding(.leading) // Add padding to separate from image
                        }
                        .padding()
                        .frame(width: 350, height: 150) // Set a fixed width and height for uniformity
                        .background(highlightedLocation == location ? Color("lightblue").opacity(0.5) : Color("lightb2").opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("darkblue"), lineWidth: 5) // Use overlay for rounded border
                        )
                        .cornerRadius(12)
                        .padding(.vertical, 5)
                        .onTapGesture {
                            highlightedLocation = location
                            region.center = location.coordinate
                        }
                        .animation(.easeInOut(duration: 0.3), value: highlightedLocation)
                    }
                }
                .padding(.top)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func getCurrentLocations() -> [Location] {
        switch selected {
        case "tutoringCenters":
            return tutoringCenters
        case "freeWifi":
            return freeWifi
        case "printers":
            return printers
        default:
            return []
        }
    }
}
