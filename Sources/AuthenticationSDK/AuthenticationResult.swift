//
//  AuthenticationResult.swift
//  AuthenticationSDK
//
//  Created by BANU HARSHAVARDHAN on 05/11/26.
//

public struct LoginResult: Decodable, Sendable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: String
}
