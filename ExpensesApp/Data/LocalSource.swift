//
//  LocalSource.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 13/09/21.
//

import Foundation
import Combine

protocol LocalSource {
    static var filePathComponent: String { get }
    func readLocalData<T: Codable>() -> AnyPublisher<T, Error>
    func saveLocalData<T: Encodable>(_ data: T) -> AnyPublisher<Void, Error>
}

extension LocalSource {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Cannot locate documents directory")
        }
    }

    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent(filePathComponent)
    }

    func readLocalData<T: Codable>() -> AnyPublisher<T, Error> {
        let future = Future<T, Error> { promise in
            DispatchQueue.global(qos: .background).async {
                do {
                    let data = try Data(contentsOf: Self.fileURL)
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    promise(.success(decodedData))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        return future.eraseToAnyPublisher()
    }

    func saveLocalData<T: Encodable>(_ data: T) -> AnyPublisher<Void, Error> {
        let future = Future<Void, Error> { promise in
            DispatchQueue.global(qos: .background).async {
                do {
                    let encodedData = try JSONEncoder().encode(data)
                    try encodedData.write(to: Self.fileURL)
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        return future.eraseToAnyPublisher()
    }
}
