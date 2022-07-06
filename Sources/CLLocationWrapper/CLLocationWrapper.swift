import CoreLocation

public struct CLLocationWrapper: Codable, Equatable {
    public var location: CLLocation
    
    public init(location: CLLocation) {
        self.location = location
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CLLocation.CodingKeys.self)
        
        let coordinateWrapper = try container.decode(CLLocationCoordinate2DWrapper.self, forKey: .coordinate)
        let altitude = try container.decode(CLLocationDistance.self, forKey: .altitude)
        let horizontalAccuracy = try container.decode(CLLocationAccuracy.self, forKey: .horizontalAccuracy)
        let verticalAccuracy = try container.decode(CLLocationAccuracy.self, forKey: .verticalAccuracy)
        let speed = try container.decode(CLLocationSpeed.self, forKey: .speed)
        let course = try container.decode(CLLocationDirection.self, forKey: .course)
        let timestamp = try container.decode(Date.self, forKey: .timestamp)

        var location = CLLocation(coordinate: coordinateWrapper.cooridnate,
                                  altitude: altitude,
                                  horizontalAccuracy: horizontalAccuracy,
                                  verticalAccuracy: verticalAccuracy,
                                  course: course,
                                  speed: speed,
                                  timestamp: timestamp)

        if #available(iOS 15.0, watchOS 8.0, tvOS 15.0, macOS 12.0, *) {
            let courseAccuracy = try container.decode(CLLocationDirectionAccuracy.self, forKey: .courseAccuracy)
            let speedAccuracy = try container.decode(CLLocationSpeedAccuracy.self, forKey: .speedAccuracy)
            let sourceInfoWrapper = try? container.decode(CLLocationSourceInformationWrapper.self, forKey: .sourceInformation)
            
            if let sourceInfoWrapper = sourceInfoWrapper {
                location = CLLocation(coordinate: coordinateWrapper.cooridnate,
                                      altitude: altitude,
                                      horizontalAccuracy: horizontalAccuracy,
                                      verticalAccuracy: verticalAccuracy,
                                      course: course,
                                      courseAccuracy: courseAccuracy,
                                      speed: speed,
                                      speedAccuracy: speedAccuracy,
                                      timestamp: timestamp,
                                      sourceInfo: sourceInfoWrapper.sourceInfo)
            }
        } else if #available(iOS 13.4, watchOS 6.2, tvOS 13.4, macOS 10.15.4, *) {
            let courseAccuracy = try container.decode(CLLocationDirectionAccuracy.self, forKey: .courseAccuracy)
            let speedAccuracy = try container.decode(CLLocationSpeedAccuracy.self, forKey: .speedAccuracy)

            location = CLLocation(coordinate: coordinateWrapper.cooridnate,
                                  altitude: altitude,
                                  horizontalAccuracy: horizontalAccuracy,
                                  verticalAccuracy: verticalAccuracy,
                                  course: course,
                                  courseAccuracy: courseAccuracy,
                                  speed: speed,
                                  speedAccuracy: speedAccuracy,
                                  timestamp: timestamp)
        }
        self.init(location: location)
    }
    
    public static func == (lhs: CLLocationWrapper, rhs: CLLocationWrapper) -> Bool {
        return lhs.location == rhs.location
    }
}
