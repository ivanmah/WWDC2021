//
//  AsyncAwaitComparisonViewModel.swift
//  WWDC2021
//
//  Created by Ivan Mah on 24/7/21.
//

import Foundation

struct AsyncAwaitComparisonViewModel {
    enum Errors: Error {
        case urlEncodingError
        case httpResponseError
        case dataEncodingError
        case otherGenericError
    }

    private let urlString = "https://jsonplaceholder.typicode.com/todos/1"

    func oldGetJSON(completion: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            if let error = error {
                completion(nil, error)
            } else if let httpResponse = urlResponse as? HTTPURLResponse,
                      httpResponse.statusCode != 200 {
                completion(nil, Errors.httpResponseError)
            } else if let data = data,
                      let jsonString = String(data: data, encoding: .utf8) {
                completion(jsonString, nil)
            } else {
                completion(nil, Errors.otherGenericError)
            }
        }

        task.resume()
    }

    func newGetJSON() async throws -> String? {
        guard let url = URL(string: urlString) else { throw Errors.urlEncodingError }

        let request = URLRequest(url: url)
        let (data, urlResponse) = try await URLSession.shared.data(for: request)

        if let httpResponse = urlResponse as? HTTPURLResponse,
           httpResponse.statusCode != 200 {
            throw Errors.httpResponseError
        }

        if let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        } else {
            throw Errors.dataEncodingError
        }
    }
}
