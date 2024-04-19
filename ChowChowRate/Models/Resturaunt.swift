//
//  Resturaunt.swift
//  GrubRate
//
//  Created by Andres Made on 4/14/24.
//

import Foundation
import FirebaseFirestoreSwift
import CoreLocation

struct Resturaunt: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var name: String
    var address: String
    var latitude = 0.0
    var longitude = 0.0
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var dictionary: [String: Any] {
        return ["name": name, "address": address, "latitude": latitude, "longitude": longitude]
    }
}
