import CoreLocation

public struct CLLocationCoordinate2DWrapper: Codable {
    var cooridnate: CLLocationCoordinate2D
    
    init(cooridnate: CLLocationCoordinate2D) {
        self.cooridnate = cooridnate
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CLLocationCoordinate2D.CodingKeys.self)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        let cooridnate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        self.init(cooridnate: cooridnate)
    }
}
