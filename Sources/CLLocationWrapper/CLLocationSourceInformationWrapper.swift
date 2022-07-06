import CoreLocation

@available(iOS 15.0, watchOS 8.0, tvOS 15.0, macOS 12.0, *)
public struct CLLocationSourceInformationWrapper: Codable {
    var sourceInfo: CLLocationSourceInformation
    
    init(sourceInfo: CLLocationSourceInformation) {
        self.sourceInfo = sourceInfo
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CLLocationSourceInformation.CodingKeys.self)
        
        let isSimulatedBySoftware = try container.decode(Bool.self, forKey: .isSimulatedBySoftware)
        let isProducedByAccessory = try container.decode(Bool.self, forKey: .isProducedByAccessory)
        
        let sourceInfo = CLLocationSourceInformation(softwareSimulationState: isSimulatedBySoftware, andExternalAccessoryState: isProducedByAccessory)

        self.init(sourceInfo: sourceInfo)
    }
}
