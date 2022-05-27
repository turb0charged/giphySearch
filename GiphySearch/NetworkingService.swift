    //
    //  NetworkingService.swift
    //  GifSearch
    //
    //  Created by on 5/26/22.
    //

import Foundation

enum NetworkError: Error {
    case malformedURL
    case requestFailed
}

protocol Networking {
    func request(query term: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) async
}

class NetworkingService: Networking {

    func request(query term: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) async {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.giphy.com"
        components.path = "/v1/gifs/search"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "229ac3e932794695b695e71a9076f4e5"),
            URLQueryItem(name: "limit", value: "50"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "rating", value: "G"),
            URLQueryItem(name: "lang", value: "en"),
            URLQueryItem(name: "q", value: term)
        ]
        guard let url = components.url else {
            completionHandler(.failure(.malformedURL))
            return
        }
        print(url)

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completionHandler(.failure(.requestFailed))
                return
            }
            completionHandler(.success(data))
        } catch let e {
            print(e)
        }
    }

}
