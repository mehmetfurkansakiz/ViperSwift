import Alamofire
import Foundation

protocol INetworkManager {
    var config: NetworkConfig { get set }
    func fetch<T: Decodable>(url: NetworkPath, method: NetworkType, type: T.Type) async -> Result<T?, Error>
}

// MARK: IT WILL USE ALL REQUESTS

class AlamofireNetworkManager: INetworkManager {
    var config: NetworkConfig

    init(config: NetworkConfig) {
        self.config = config
    }

    static let shared: INetworkManager = AlamofireNetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseUrl))

    /// Fetch All Request
    /// - Parameters:
    ///   - url: network path
    ///   - method: network type
    /// - Returns: if everyting is okey will return T type else it will return error
    func fetch<T: Decodable>(url: NetworkPath, method: NetworkType, type: T.Type) async -> Result<T?, Error> {
        let request = AF.request("\(config.baseUrl)/\(url.rawValue)", method: method.toAlamofire())
            .validate()
            .serializingDecodable(T.self)

        let result = await request.response

        guard let value = result.value else {
            return .failure(CustomError.networkError)
        }

        return .success(value)
    }
}
