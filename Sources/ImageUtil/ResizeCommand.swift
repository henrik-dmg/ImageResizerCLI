import Foundation
import ArgumentParser
import HPImageUtils

struct ResizeCommand: ParsableCommand {

	static let configuration = CommandConfiguration(
		commandName: "resize",
		abstract: "Resizes an input image to a specified scale",
		version: "2.0.0",
		helpNames: .shortAndLong
	)

    @Argument(help: "The image that should be resized")
    var image: URL

    @Option(name: .shortAndLong, help: "The custom output path of the resized image")
    var output: URL?

    @Option(name: .shortAndLong, help: "The scale to which the image should be scaled in percent")
    var scale: Int

    @Option(name: .shortAndLong, help: "The format of the output image")
    var format: ImageFormat

    @Flag(help: "Prints additional information during rendering")
    var verbose = false

    func run() throws {
        var isDirectory = ObjCBool(false)
        guard FileManager.default.fileExists(atPath: image.path, isDirectory: &isDirectory), !isDirectory.boolValue else {
            throw NSError(description: "The specified path does not exist or is a directory")
        }

        let resizer = try ImageResizer(sourceURL: image)
        let outputURL = makeOutputPath(for: output ?? image, scale: scale, format: format)
        try resizer.scaleImage(to: CGFloat(scale) / 100, destinationURL: outputURL, format: format)
    }

    func makeOutputPath(for url: Foundation.URL, scale: Int, format: ImageFormat) -> Foundation.URL {
        let pathExtension = format.fileEndings.first ?? "wumbojumbo"
        let droppedURL = url.deletingPathExtension()

        let fileName = droppedURL.lastPathComponent + "@\(scale)"
        let constructedFileName = [fileName, pathExtension].compactMap { $0 }.joined(separator: ".")

        return url.deletingLastPathComponent().appendingPathComponent(constructedFileName)
    }

}

extension URL: ExpressibleByArgument {

    public init?(argument: String) {
		guard let url = URL.parse(argument) else {
			return nil
		}
		self = url
    }

}

extension ImageFormat: ExpressibleByArgument {

    public init?(argument: String) {
        guard let resolvedType = ImageFormat.allCases.first(where: { $0.fileEndings.contains(argument.lowercased()) }) else {
            return nil
        }
        self = resolvedType
    }

}
