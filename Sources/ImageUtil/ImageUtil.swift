import ArgumentParser
import Foundation

@main
struct ImageUtil: ParsableCommand {

	static var configuration: CommandConfiguration {
		CommandConfiguration(
			commandName: "imageutil",
			abstract: "A utility to perform some common image operations",
			version: "1.0.0",
			subcommands: [ResizeCommand.self, SkewCommand.self],
			helpNames: .shortAndLong
		)
	}

}
