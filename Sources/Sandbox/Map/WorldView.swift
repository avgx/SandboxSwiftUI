//
//  WorldView.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 04.04.2022.
//

import MapKit
import SwiftUI

struct WorldViewWrap: View {
    var body: some View {
        NavigationView {
            WorldView()
        }
    }
}

struct WorldView: View {
    let locations: WorldLocations = WorldLocations()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40))
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations.places) { location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                NavigationLink(
                destination: WorldLocationView(location: location)) {
                    Image(systemName: "mappin.and.ellipse")//location.country)
                        .resizable()
                        .cornerRadius(20)
                        .frame(width: 40, height: 40)
                        .shadow(radius: 3)
                }
            }
        }
        .navigationTitle("Locations")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WorldView_Previews: PreviewProvider {
    static var previews: some View {
        WorldView()
    }
}

class WorldLocations: ObservableObject {
    let places: [WorldLocation]
    
    var primary: WorldLocation {
        places.first ?? WorldLocation(id: 0, name: "", country: "", worldLocationDescription: "", more: "", latitude: 0, longitude: 0, heroPicture: "", pictures: [], advisory: "")
    }
    
    init() {
        guard let data = LOCATIONS_JSON.data(using: .utf8),
              let locations = try? JSONDecoder().decode([WorldLocation].self, from: data) else {
            places = []
            return
        }
        places = locations
    }
}

struct WorldLocation: Decodable, Identifiable {
    let id: Int
    let name: String
    let country: String
    let worldLocationDescription: String
    let more: String
    let latitude: Double
    let longitude: Double
    let heroPicture: String
    let pictures: [String]
    let advisory: String
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case country = "country"
            case worldLocationDescription = "description"
            case more = "more"
            case latitude = "latitude"
            case longitude = "longitude"
            case heroPicture = "heroPicture"
            case pictures = "pictures"
            case advisory = "advisory"
        }
}

fileprivate let LOCATIONS_JSON = """
[
    {
        "id": 1,
        "name": "The Highlands",
        "country": "United Kingdom",
        "description": "The Highlands is a historic region of Scotland. Culturally, the Highlands and the Lowlands diverged from the later Middle Ages into the modern period, when Lowland Scots replaced Scottish Gaelic throughout most of the Lowlands. The term is also used for the area north and west of the Highland Boundary Fault, although the exact boundaries are not clearly defined, particularly to the east. The Great Glen divides the Grampian Mountains to the southeast from the Northwest Highlands. The Scottish Gaelic name of A' Ghàidhealtachd literally means 'the place of the Gaels' and traditionally, from a Gaelic-speaking point of view, includes both the Western Isles and the Highlands.",
        "more": "The area is very sparsely populated, with many mountain ranges dominating the region, and includes the highest mountain in the British Isles, Ben Nevis. During the 18th and early 19th centuries the population of the Highlands rose to around 300,000, but from c. 1841 and for the next 160 years, the natural increase in population was exceeded by emigration (mostly to Canada, the United States, Australia and New Zealand, and migration to the industrial cities of Scotland and England.) The area is now one of the most sparsely populated in Europe. At 9.1/km2 (24/sq mi) in 2012, the population density in the Highlands and Islands is less than one seventh of Scotland's as a whole, comparable with that of Bolivia, Chad and Russia.",
        "latitude": 57.1200,
        "longitude": -4.7100,
        "heroPicture": "highlands",
        "pictures": ["photo2", "photo3", "photo4"],
        "advisory": "We accept no liability for any visitors eaten alive by midges."
    },
    {
        "id": 2,
        "name": "Great Smoky Mountains",
        "country": "United States",
        "description": "The Great Smoky Mountains are a mountain range rising along the Tennessee–North Carolina border in the southeastern United States. They are a subrange of the Appalachian Mountains, and form part of the Blue Ridge Physiographic Province. The range is sometimes called the Smoky Mountains and the name is commonly shortened to the Smokies. The Great Smokies are best known as the home of the Great Smoky Mountains National Park, which protects most of the range. The park was established in 1934, and, with over 11 million visits per year, it is the most visited national park in the United States.",
        "more": "The Great Smokies are part of an International Biosphere Reserve. The range is home to an estimated 187,000 acres (76,000 ha) of old growth forest, constituting the largest such stand east of the Mississippi River. The cove hardwood forests in the range's lower elevations are among the most diverse ecosystems in North America, and the Southern Appalachian spruce-fir forest that coats the range's upper elevations is the largest of its kind. The Great Smokies are also home to the densest black bear population in the Eastern United States and the most diverse salamander population outside of the tropics.",
        "latitude": 35.6532,
        "longitude": -83.5070,
        "heroPicture": "smokies",
        "pictures": ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8"],
        "advisory": "We accept no liability for any visitors eaten alive by bears."
    }
]
"""

struct WorldLocationView: View {
    let location: WorldLocation
    
    var body: some View {
        ScrollView {
//            Image(location.heroPicture)
//                .resizable()
//                .scaledToFit()
            
            Text(location.name)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
            Text(location.country)
                .font(.title)
                .foregroundColor(.secondary)
            
            if !location.advisory.isEmpty {
                DisclosureGroup(content: {
                    Text(location.advisory)
                }) {
                    Text("Travel advisories")
                        .bold()
                }
                .padding()
            }
            
            Text(location.worldLocationDescription)
                .padding(.horizontal)
            
            Text("Did you know?")
                .font(.title3)
                .bold()
                .padding(.top)
            
            Text(location.more)
                .padding([.horizontal])
            
            Text("Pictures")
                .font(.title3)
                .bold()
                .padding(.top)
            
//            VStack {
//                ForEach(location.pictures, id: \.self) { picture in
//                    Image(picture)
//                        .resizable()
//                        .scaledToFit()
//                }
//            }
//            .padding(.bottom)
        }
        .navigationTitle("Discover")
    }
}
