import Alamofire
import Foundation

enum CustomError: Error {
    case networkError
}

enum NetworkPath: String {
    case http = "http.json"
    case dummy = "dummy.json"
    
    static let baseUrl: String = ProductConstants.BASE_URL
}

enum NetworkType {
    case get
    case post
}

extension NetworkType {
    func toAlamofire() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}
