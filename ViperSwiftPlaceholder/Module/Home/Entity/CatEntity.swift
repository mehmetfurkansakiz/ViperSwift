import Foundation

struct CatEntity: Codable {
    let description: String
    let imageURL: String
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case description
        case imageURL = "imageUrl"
        case statusCode
    }
}
