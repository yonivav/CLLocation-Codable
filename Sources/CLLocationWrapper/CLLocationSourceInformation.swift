import CoreLocation

@available(iOS 15.0, watchOS 8.0, tvOS 15.0, macOS 12.0, *)
extension CLLocationSourceInformation: Encodable {

    enum CodingKeys: String, CodingKey {
        case isSimulatedBySoftware, isProducedByAccessory
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isSimulatedBySoftware, forKey: .isSimulatedBySoftware)
        try container.encode(isProducedByAccessory, forKey: .isProducedByAccessory)
    }
    
    static func == (lhs: CLLocationSourceInformation, rhs: CLLocationSourceInformation) -> Bool {
        return lhs.isSimulatedBySoftware == rhs.isSimulatedBySoftware &&
            lhs.isProducedByAccessory == rhs.isProducedByAccessory
    }
}
