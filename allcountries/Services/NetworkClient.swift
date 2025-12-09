//
//  NetworkClient.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import Foundation

final class NetworkClient {
    
    func request<T: Decodable>(_ request: URLRequest, type: T.Type) async -> Result<T, NetworkError> {
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            switch httpResponse.statusCode {
                
            case 200...299:
                // Handle Data passthrough
                if T.self == Data.self {
                    return .success(data as! T)
                }
                
                // Handle empty payload (e.g., 204 No Content)
                if data.isEmpty, let empty = Empty() as? T {
                    return .success(empty)
                }
                
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    return .success(decoded)
                } catch {
                    print("❌ Decoding error:", error)
                    return .failure(.decoding(error))
                }
                
            case 400:
                return .failure(.badRequest)
                
            case 401:
                return .failure(.unauthorized)
                
            case 403:
                return .failure(.forbidden)
                
            case 404:
                return .failure(.notFound)
                
            case 429:
                return .failure(.tooManyRequests)
                
            case 500...599:
                return .failure(.serverError(code: httpResponse.statusCode))
                
            default:
                return .failure(.unexpectedStatus(httpResponse.statusCode))
            }
            
        } catch let urlError as URLError {
            return .failure(.url(urlError))
        } catch {
            return .failure(.unknown(error))
        }
    }
}

extension NetworkClient {
    enum NetworkError: Error, LocalizedError {
        case url(URLError)
        case decoding(Error)
        case invalidResponse
        case badRequest
        case unauthorized
        case forbidden
        case notFound
        case tooManyRequests
        case serverError(code: Int)
        case unexpectedStatus(Int)
        case unknown(Error)
        
        var errorDescription: String? {
            switch self {
            case .url(let err): return "\(L10n.urlError): \(err.localizedDescription)"
            case .decoding(let err): return "\(L10n.decodingError): \(err.localizedDescription)"
            case .invalidResponse: return L10n.invalidResponse
            case .badRequest: return L10n.badRequest
            case .unauthorized: return L10n.unauthorized
            case .forbidden: return L10n.forbidden
            case .notFound: return L10n.notFound
            case .tooManyRequests: return L10n.tooManyRequests
            case .serverError(let code): return "\(L10n.serverError): \(code)"
            case .unexpectedStatus(let code): return "\(L10n.unexpectedStatus): \(code)"
            case .unknown(let err): return "\(L10n.unknownError): \(err.localizedDescription)"
            }
        }
    }
}

struct Empty: Decodable {}
