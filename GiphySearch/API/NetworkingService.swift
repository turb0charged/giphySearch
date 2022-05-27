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
        components.scheme = URLConstants.httpsScheme
        components.host = URLConstants.host
        components.path = URLConstants.GifSearch.path
        components.queryItems = [
            URLQueryItem(name: URLConstants.GifSearch.apiKeyParam, value:  URLConstants.apiKey),
            URLQueryItem(name: URLConstants.GifSearch.limitParam, value: "50"),
            URLQueryItem(name: URLConstants.GifSearch.offsetParam, value: "0"),
            URLQueryItem(name: URLConstants.GifSearch.ratingParam, value: "G"),
            URLQueryItem(name: URLConstants.GifSearch.languageParam, value: "en"),
            URLQueryItem(name: URLConstants.GifSearch.queryParam, value: term)
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
