//
//  URLConstants.swift
//  GiphySearch
//
//  Created by Hector Castillo on 5/27/22.
//

import Foundation

struct URLConstants {
    static let httpsScheme = "https"
    static let host = "api.giphy.com"

    static var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "keys", ofType: "plist") else {
                fatalError("Couldn't find file 'keys.plist'")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "GIPHY_API_KEY") as? String else {
                fatalError("Couldn't find key 'GIPHY_API_KEY' in 'keys.plist'")
            }
            return value
        }
    }

    struct GifSearch {
        static let path = "/v1/gifs/search"
        static let apiKeyParam = "api_key"
        static let limitParam = "limit"
        static let offsetParam = "offset"
        static let ratingParam = "rating"
        static let languageParam = "lang"
        static let queryParam = "q"
    }

}
