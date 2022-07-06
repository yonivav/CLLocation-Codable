import CoreLocation

extension CLLocation: Encodable {
    internal enum CodingKeys: String, CodingKey {
        case coordinate, altitude, horizontalAccuracy, verticalAccuracy, speed, course, timestamp, speedAccuracy, courseAccuracy, sourceInformation
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate, forKey: .coordinate)
        try container.encode(altitude, forKey: .altitude)
        try container.encode(horizontalAccuracy, forKey: .horizontalAccuracy)
        try container.encode(verticalAccuracy, forKey: .verticalAccuracy)
        try container.encode(speed, forKey: .speed)
        try container.encode(course, forKey: .course)
        try container.encode(timestamp, forKey: .timestamp)
        if #available(iOS 10.0, watchOS 3.0, tvOS 10.0, macOS 10.15, *) {
            try container.encode(speedAccuracy, forKey: .speedAccuracy)
        }
        if #available(iOS 13.4, watchOS 6.2, tvOS 13.4, macOS 10.15.4, *) {
            try container.encode(courseAccuracy, forKey: .courseAccuracy)
            try container.encode(courseAccuracy, forKey: .sourceInformation)
        }
        if #available(iOS 15.0, watchOS 8.0, tvOS 15.0, macOS 12.0, *) {
            try container.encode(sourceInformation, forKey: .sourceInformation)
        }
    }
    
    static func == (lhs: CLLocation, rhs: CLLocation) -> Bool {
        let isBasicParamsEqual = lhs.coordinate == rhs.coordinate &&
            lhs.altitude == rhs.altitude &&
            lhs.horizontalAccuracy == rhs.horizontalAccuracy &&
            lhs.verticalAccuracy == rhs.verticalAccuracy &&
            lhs.course == rhs.course &&
            lhs.speed == rhs.speed &&
            lhs.timestamp == rhs.timestamp
        
        if #available(iOS 15.0, watchOS 8.0, tvOS 15.0, macOS 12.0, *) {
            let moreParams = isBasicParamsEqual &&
                lhs.courseAccuracy == rhs.courseAccuracy &&
                lhs.speedAccuracy == rhs.speedAccuracy
            
            if let leftSourceInformation = lhs.sourceInformation,
               let rightSourceInformation = rhs.sourceInformation,
               leftSourceInformation == rightSourceInformation {
                return moreParams
            } else if lhs.sourceInformation == nil,
                      rhs.sourceInformation == nil {
                return moreParams
            } else {
                return false
            }
        } else if #available(iOS 13.4, watchOS 6.2, tvOS 13.4, macOS 10.15.4, *) {
            return isBasicParamsEqual &&
                lhs.courseAccuracy == rhs.courseAccuracy &&
                lhs.speedAccuracy == rhs.speedAccuracy
        } else {
            return isBasicParamsEqual
        }
    }
}
