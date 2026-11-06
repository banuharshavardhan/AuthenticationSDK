// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol AuthenticationProvider: Sendable {
    func login(username: String, password: String) async throws -> LoginResult
}

public final class AuthenticationSDK {
    
    private let respository: AuthenticationRepositoryProvider
    
    public init(networkClient: NetworkClientProvider = NetworkClient.shared) {
        self.respository = AuthenticationRepository(
            service: AuthenticationService(
                networkClient: networkClient
            )
        )
    }
}

extension AuthenticationSDK: AuthenticationProvider {
    public func login(username: String, password: String) async throws -> LoginResult {
        try await respository.authenticate(username: username, password: password)
    }
}
