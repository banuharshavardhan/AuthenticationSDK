//
//  NetwotkClient.swift
//  AuthenticationSDK
//
//  Created by BANU HARSHAVARDHAN on 05/11/26.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

public enum Endpoint: Sendable {
    case login
}

public protocol NetworkClientProvider: Sendable {
    func execute<Request: Encodable & Sendable, Response: Decodable & Sendable>(
        endpoint: Endpoint,
        body: Request,
        responseType: Response.Type
    ) async throws -> Response
}

public actor NetworkClient {
    private init() {}
    public static let shared = NetworkClient()
}

extension NetworkClient: NetworkClientProvider {
    public func execute<Request: Sendable, Response: Sendable>(
        endpoint: Endpoint,
        body: Request,
        responseType: Response.Type
    ) async throws -> Response where Request : Encodable, Response : Decodable {
        // Replace with base url and endpoint usage
        guard let url = URL(string: "https://ikotzktasmjmjkhuctgt.supabase.co") else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let jsonData = try JSONEncoder().encode(body)
        urlRequest.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(
            for: urlRequest,
            delegate: NetworkSessionDelegate()
        )
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        return try JSONDecoder().decode(responseType, from: data)
    }
}

final class NetworkSessionDelegate: NSObject, URLSessionDataDelegate {
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didReceive challenge: URLAuthenticationChallenge
    ) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        (.performDefaultHandling, nil)
    }
}
