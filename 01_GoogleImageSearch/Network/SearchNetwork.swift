//
//  SearchNetwork.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/14/24.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case invalidURL
    case invalidJSON
    case invalidNetwork
}

struct SearchNetwork {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getData(query: String) -> Single<Result<GGImageResults, NetworkError>> {
        guard let url = GoogleAPI().urlComponents(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = URLRequest(url: url)
        
        return session.rx.data(request: request)
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode(GGImageResults.self, from: data)
                    return .success(decoded)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch({ _ in
                return .just(.failure(.invalidNetwork))
            })
            .asSingle()
        
    }
    
}
