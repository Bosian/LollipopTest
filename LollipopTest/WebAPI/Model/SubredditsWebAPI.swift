//
//  Subreddits.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/25.
//

import Foundation

struct SubredditsWebAPI {
    let url = URL(string: "https://www.reddit.com/subreddits/default.json")!

    func invokeAsync(completion: @escaping (Result<Subreddits, Error>) -> Void) {
        let request = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in

            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                
                do {
                    let model = try Subreddits(data: data)
                    completion(.success(model))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }

    @MainActor
    func invokeAsync () async throws -> Subreddits {
        let request = URLRequest(url: url)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try Subreddits(data: data)
        } catch {
            print(error)
            throw error
        }
    }
}
