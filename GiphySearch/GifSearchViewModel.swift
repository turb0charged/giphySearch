    //
    //  GifSearchViewModel.swift
    //  GifSearch
    //
    //  Created by Hector Castillo on 5/26/22.
    //

import Foundation

protocol GifSearchViewModelType: AnyObject {
    var gifs: [Datum] { get }
    var gifsLoaded: (([Datum]) -> Void)? { get set }
    func fetchGifs(withSearchTerm searchTerm: String)
}


class GifSearchViewModel: GifSearchViewModelType {
    var gifs: [Datum] = []
    {
        didSet{
            gifsLoaded?(gifs)
        }
    }
    var gifsLoaded: (([Datum]) -> Void)?

    let networkingService: Networking

    init(networkingService: Networking) {
        self.networkingService = networkingService
    }

    func fetchGifs(withSearchTerm searchTerm: String) {
        Task {
            await networkingService.request(query: searchTerm) { [self] result in
                switch result {
                    case .success(let data):
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .iso8601
                        do {
                            let responseData = try jsonDecoder.decode(GIFQueryResult.self, from: data)
                            gifs = responseData.data
                        } catch let e {
                            print(e)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
}


