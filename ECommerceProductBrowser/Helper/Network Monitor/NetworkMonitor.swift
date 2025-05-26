//
//  NetworkMonitor.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 26/05/25.
//


import Network
import Combine

final class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    @Published private(set) var isConnected: Bool = true

    // Shared publisher that emits distinct values and shares the stream
    lazy var connectionStatusPublisher: AnyPublisher<Bool, Never> = {
        $isConnected
            .removeDuplicates()
            .share()
            .eraseToAnyPublisher()
    }()

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}

