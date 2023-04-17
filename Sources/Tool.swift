import Foundation

struct Tool: Decodable {
    let name: String
    let url: URL
    let path: String
    let checksum: String
}
