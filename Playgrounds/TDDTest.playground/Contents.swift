@testable import AppStoreFramework
import PlaygroundSupport
import UIKit



public class MockFetcher: DataFetching {
    public func fetchData(url : URL, completion: @escaping (Data?, Error?) -> Void) {
        print("override")
        completion(nil, nil)
    }
}

let appStoreRessource = AppStoreRessource(dataFetcher: MockFetcher())

appStoreRessource.getApps(top: 10, appType: .free) { apps, _ in
    apps.compactMap {
        print($0.name)
    }
}
