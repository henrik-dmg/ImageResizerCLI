import ArgumentParser
import Foundation
import HPImageUtils

struct SkewCommand: ParsableCommand {

	static let configuration = CommandConfiguration(
		commandName: "skew",
		abstract: "Skews an input image to the provided corners",
		version: "2.0.0",
		helpNames: .shortAndLong
	)

	@Argument(help: "The image that should be resized")
	var image: URL

	@Option(name: .shortAndLong, help: "The custom output path of the resized image")
	var output: URL

	@Option(name: .shortAndLong, help: "The path of the configuration file specifying where each corner of the input image will be rendered", completion: .file(extensions: ["json"]))
	var configurationFile: URL

	@Flag(help: "Prints additional information during rendering")
	var verbose = false

	func run() throws {
		print("Test")
		print(image.path)
		print(output.path)
		print(configurationFile.path)
		let data = try Data(contentsOf: configurationFile)
		let config = try JSONDecoder().decode(ImageSkewer.Configuration.self, from: data)
		try ImageSkewer(sourceURL: image).skewImage(
			configuration: config,
			outputURL: output
		)
	}

}

extension URL {

	static func parse(_ string: String) -> URL? {
		guard !string.isEmpty else {
			return nil
		}
		if string.hasPrefix("~") {
			return URL.init(fileURLWithPath: String(string.dropFirst()), relativeTo: FileManager.default.homeDirectoryForCurrentUser)
		} else if string.hasPrefix("/Users") {
            print("Absolute URL")
			return URL(fileURLWithPath: string)
		} else {
			return URL(fileURLWithPath: string, relativeTo: URL(fileURLWithPath: FileManager.default.currentDirectoryPath))
		}
	}

}
