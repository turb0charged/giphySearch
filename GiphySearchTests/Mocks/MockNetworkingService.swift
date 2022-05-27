//
//  MockNetworkingService.swift
//  GiphySearchTests
//
//  Created by Hector Castillo on 5/27/22.
//

import Foundation
@testable import GiphySearch

class NetworkingServiceMock: Networking {
    var getArguments: [String?] = []
    var getCallsCount: Int = 0
    var showError: Bool = false

    func request(query term: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) async {
        getArguments.append(term)
        getCallsCount += 1

        if showError {
            completionHandler(.failure(.requestFailed))
        } else {
            completionHandler(.success(Data()))
        }
    }


}
