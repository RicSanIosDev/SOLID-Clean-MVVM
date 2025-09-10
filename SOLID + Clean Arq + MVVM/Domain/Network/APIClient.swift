//
//  APIClient.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case invalidData
}

class APIClient {
    func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {
            data,
            response,
            error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(
                    .failure(
                        APIError.invalidResponse
                    )
                )
                return
            }

            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
