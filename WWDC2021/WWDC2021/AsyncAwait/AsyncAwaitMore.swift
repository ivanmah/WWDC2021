//
//  AsyncAwaitMore.swift
//  WWDC2021
//
//  Created by Ivan Mah on 25/7/21.
//

import CoreData
import Foundation

struct AsyncAwaitMore {
    let fakeURLString = "https://www.google.com"
    let fakeFilePathString = "/this/is_a/fake/path"

    private func urlSessionUpload() async throws {
        guard let url = URL(string: fakeURLString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let (_, _) = try await URLSession.shared.upload(for: request, from: Data())

        // ...
    }

    private func urlSessionDownload() async throws {
        guard let url = URL(string: fakeURLString) else { return }

        let (_, _) = try await URLSession.shared.download(from: url)

        // ...
    }

    private func urlSessionBytes() async throws {
        guard let url = URL(string: fakeURLString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let (bytes, _) = try await URLSession.shared.bytes(for: request)

        // ...

        for try await _ in bytes {
            // ...
        }
    }

    private func readFromFileHandle() async throws {
        guard let fileHandle = FileHandle(forReadingAtPath: fakeFilePathString) else { return }

        for try await _ in fileHandle.bytes.lines {
            // ...
        }
    }

    private func readFromURL() async throws {
        guard let url = URL(string: fakeFilePathString) else { return }

        for try await _ in url.lines {
            // ...
        }
    }

    private func readNotifications() async {
        let notificationCenter = NotificationCenter.default
        let _ = await notificationCenter.notifications(named: .NSCalendarDayChanged).first(where: { notification in
            return true
        })

        // ...
    }

    private func asyncCancellation() throws {
        guard let url = URL(string: fakeURLString) else { return }

        let asyncTask = Task {
            let (_, _) = try await URLSession.shared.download(from: url)
            let (_, _) = try await URLSession.shared.download(from: url)
        }

        asyncTask.cancel()
    }
}
