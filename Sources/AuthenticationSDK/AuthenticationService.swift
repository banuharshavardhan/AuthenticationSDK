//
//  AuthenticationService.swift
//  AuthenticationSDK
//
//  Created by BANU HARSHAVARDHAN on 05/11/26.
//

import Foundation

public protocol AuthenticationServiceProvider: Sendable {
    func login(model: LoginModel) async throws -> LoginResult
}

public final class AuthenticationService: AuthenticationServiceProvider {
    
    private let networkClient: NetworkClientProvider
    
    init(networkClient: NetworkClientProvider) {
        self.networkClient = networkClient
    }
    
    public func login(model: LoginModel) async throws -> LoginResult {
        try await networkClient.execute(
            endpoint: .login,
            body: model,
            responseType: LoginResult.self
        )
    }
}
