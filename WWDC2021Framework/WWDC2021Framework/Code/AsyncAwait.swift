//
//  AsyncAwait.swift
//  WWDC2021
//
//  Created by Ivan Mah on 14/6/21.
//

import Foundation
import UIKit

struct AsyncAwait {
    func fetchImage(id: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let request = getImageURLRequest(for: id)
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                completion(nil, error)
            } else if let httpResponse = urlResponse as? HTTPURLResponse,
                      httpResponse.statusCode != 200 {
                completion(nil, MyTransferError())
            } else if let data = data,
                      let image = UIImage(data: data) {
                completion(image, nil)
            } else {
                completion(nil, MyOtherError())
            }
        }

        task.resume()
    }

    func fetchImage(id: String) async throws -> UIImage {
        let request = getImageURLRequest(for: id)
        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode != 200 { throw TransferFailure() }

        guard let image = UIImage(data: data) else { throw ImageDecodingFailure() }

        return image
    }

    func urlSessionUpload() async throws {
        var request = URLRequest(url: getURL1())
        request.httpMethod = "POST"

        let (data, response) = try await URLSession.shared.upload(for: request, fromFile: getFileURL())

        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 201 else { throw InvalidServerResponse() } // 201 == HTTP 201 Created
    }

    func urlSessionDownload() async throws {
        let (location, response) = try await URLSession.shared.download(from: getURL1())

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw InvalidServerResponse() }

        try FileManager.default.moveItem(at: location, to: getFileURL())
    }

    func urlSessionBytes() async throws {
        let (bytes, response) = try await URLSession.shared.bytes(from: getURL1())

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw InvalidServerResponse() }

        for try await line in bytes.lines {
            let photoMetadata = try JSONDecoder().decode(PhotoMetadata.self, from: Data(line.utf8))

            await updateFavouriteCount(with: photoMetadata)
        }
    }

    func urlSessionCancellation() {
        let asyncTask = async {
            let (data1, response1) = try await URLSession.shared.data(from: getURL1())
            let (data2, response2) = try await URLSession.shared.data(from: getURL2())

            // …
        }

        asyncTask.cancel()
    }

    func asyncNotifications() async {
        let center = NotificationCenter.default
        let notification = await center.notifications(named: .NSURLCredentialStorageChanged).first {
            if let firstString = $0.userInfo?.values.first as? String,
               firstString == "randomValue" {
                return true
            }

            return false
        }
    }

    func getImageURLRequest(for id: String) -> URLRequest {
        return URLRequest(url: getURL1())
    }

    func updateFavouriteCount(with photoMetaData: PhotoMetadata) async {

    }

    func getURL1() -> URL {
        return URL(string: "https://www.dbs.com")!
    }

    func getURL2() -> URL {
        return URL(string: "https://www.dbs.com")!
    }

    func getFileURL() -> URL {
        return URL(string: "/tmp/file1.txt")!
    }

    struct MyTransferError: Error {

    }

    struct MyOtherError: Error {

    }

    struct TransferFailure: Error {

    }

    struct ImageDecodingFailure: Error {

    }

    struct InvalidServerResponse: Error {

    }

    struct PhotoMetadata: Decodable {

    }

    func counterIncrement() {
        let counter = Counter()

        asyncDetached {
            counter.increment()

            print(counter.value)
        }

        asyncDetached {
            counter.increment()

            print(counter.value)
        }
    }

    func counterActorIncrement() {
        let counterActor = CounterActor()

        asyncDetached {
            await counterActor.increment()

            await print(counterActor.value)
        }

        asyncDetached {
            await counterActor.increment()

            await print(counterActor.value)
        }
    }
}

class Counter {
    var value = 0

    func increment() {
        value += 1
    }
}

actor CounterActor {
    var value = 0

    func increment() {
        value += 1
    }

    func resetSlowly(to newValue: Int) {
        value = 0

        for _ in 0 ..< newValue {
            increment()
        }
    }
}
