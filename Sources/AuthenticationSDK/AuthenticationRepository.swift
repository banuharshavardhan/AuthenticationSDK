//
//  AuthenticationRepository.swift
//  AuthenticationSDK
//
//  Created by BANU HARSHAVARDHAN on 05/11/26.
//

import Foundation

public protocol AuthenticationRepositoryProvider: Sendable {
    func authenticate(username: String, password: String) async throws -> LoginResult
}

public final class AuthenticationRepository: AuthenticationRepositoryProvider {
    
    private let service: AuthenticationServiceProvider
    
    public init(service: AuthenticationServiceProvider) {
        self.service = service
    }
    
    public func authenticate(username: String, password: String) async throws -> LoginResult {
        try await service.login(
            model: LoginModel(
                username: username,
                password: password
            )
        )
    }
}
