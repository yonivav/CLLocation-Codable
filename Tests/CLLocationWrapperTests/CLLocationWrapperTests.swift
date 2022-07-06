import XCTest
import CoreLocation

@testable import CLLocationWrapper

final class CLLocationWrapperTests: XCTestCase {
    func testCLLocationExtension_WhenLocationWrapsSavedAndLoaded_ThenItContainsTheSameData() {
        
        // erase location in user defaults
        saveToUserDefaults(locationWrapper: nil)
        var loadedLocationWrapper = loadFromUserDefaults()
        XCTAssertNil(loadedLocationWrapper)
        
        // save location into user defaults
        let location: CLLocation!
        if #available(iOS 15.0, watchOS 8.0, tvOS 15.0, macOS 12.0, *) {
            location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 16.6, longitude: 12.5),
                                  altitude: 2.6,
                                  horizontalAccuracy: 1.8,
                                  verticalAccuracy: 9,
                                  course: 46.891,
                                  courseAccuracy: 65.2,
                                  speed: 1.5,
                                  speedAccuracy: 0,
                                  timestamp: Date(),
                                  sourceInfo: CLLocationSourceInformation(softwareSimulationState: true,
                                                                          andExternalAccessoryState: false))
        } else if #available(iOS 13.4, tvOS 13.4, *) {
            location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 16.6, longitude: 12.5),
                                  altitude: 2.6,
                                  horizontalAccuracy: 1.8,
                                  verticalAccuracy: 9,
                                  course: 46.891,
                                  courseAccuracy: 65.2,
                                  speed: 1.5,
                                  speedAccuracy: 0,
                                  timestamp: Date())
        } else {
            location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 16.6, longitude: 12.5),
                                  altitude: 2.6,
                                  horizontalAccuracy: 1.8,
                                  verticalAccuracy: 9,
                                  course: 46.891,
                                  speed: 1.5,
                                  timestamp: Date())
        }
        let locationWrapper = CLLocationWrapper(location: location)
        XCTAssertNotNil(locationWrapper.location)
       
        // load location from user defaults
        saveToUserDefaults(locationWrapper: locationWrapper)
        loadedLocationWrapper = loadFromUserDefaults()
        XCTAssertTrue(loadedLocationWrapper == locationWrapper)
    }
    
    private func saveToUserDefaults(locationWrapper: CLLocationWrapper?) {
        if let locationWrapper = locationWrapper,
           let encoded = try? JSONEncoder().encode(locationWrapper.location) {
            UserDefaults.standard.set(encoded, forKey: "locationWrapperTest")
        } else {
            UserDefaults.standard.set(nil, forKey: "locationWrapperTest")
        }
    }
    
    private func loadFromUserDefaults() -> CLLocationWrapper? {
        if let da = UserDefaults.standard.value(forKey: "locationWrapperTest") as? Data,
           let object = try? JSONDecoder().decode(CLLocationWrapper.self, from: da) {
            return object
        }
        return nil
    }
}
