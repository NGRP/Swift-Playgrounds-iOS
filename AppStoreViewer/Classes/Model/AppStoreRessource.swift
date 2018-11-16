//
//  AppStoreRessource.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 17/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation

public enum AppType: String {
    case paid = "Paid"
    case free = "Free"

    var appStoreRessourceURL: String {
        switch self {
        case .paid:
            return "https://itunes.apple.com/us/rss/toppaidapplications"
        case .free:
            return "https://itunes.apple.com/us/rss/topfreeapplications"
        }
    }
}

public class AppStoreRessource: DataFetching {

    private struct ServerResponse: Decodable {
        let feed: Feed
    }

    private struct Feed: Decodable {
        let entry: [App]
    }

    public func getApps(top: Int, appType: AppType, completion: @escaping ([App], Error?) -> Void) {

        let limitString = "/limit=\(top)/json"

        let urlString = appType.appStoreRessourceURL + limitString

        let url = URL(string: urlString)

        fetchData(url: url!) { (data, dataError) in

            var apps = [App]()
            var parseError = dataError

            defer {
                completion(apps, parseError)
            }

            guard let data = data else {
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let serverResponse = try jsonDecoder.decode(ServerResponse.self, from: data)
                apps = serverResponse.feed.entry
            }
            catch {
                parseError = error
            }
        }
    }
}
