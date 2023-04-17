import ArgumentParser
import Foundation
import Yams

@main
struct lid: ParsableCommand {
    @Option(
        help: "Path to the manifest file",
        completion: .file(extensions: ["yml", "yaml"]),
        transform: URL.init(fileURLWithPath:)
    )
    var manifestPath: URL

    @Option(
        help: "Path to place downloaded (and decompressed) items",
        completion: .directory,
        transform: URL.init(fileURLWithPath:)
    )
    var destination: URL

    mutating func run() throws {
        let tools = try decodeManifestFile(at: manifestPath)
        for tool in tools {
            try downloadToolToTempDir(tool: tool)
        }
    }

    func decodeManifestFile(at manifestURL: URL) throws -> [Tool] {
        let data = try Data(contentsOf: manifestURL)
        let tools = try YAMLDecoder().decode([Tool].self, from: data)
        return tools
    }

    func downloadToolToTempDir(tool: Tool) throws {
        let downloadTask = URLSession.shared.downloadTask(with: tool.url) {
            location, response, error in

            if let error {
                print(error.localizedDescription)
                return
            }

            guard
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
            else {
                print("response be bad")
                return
            }

            guard let location else {
                print("location ain't got no value")
                return
            }

            let tempDir = FileManager.default.temporaryDirectory
            let savedURL = tempDir.appendingPathComponent(location.lastPathComponent)
            print(savedURL)
        }
        downloadTask.resume()
    }
}

enum lidError: Error {
    case invalidManifestPath
}
