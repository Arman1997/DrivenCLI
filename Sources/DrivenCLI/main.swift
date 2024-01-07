import ArgumentParser
import Foundation
import Driven


struct Driven: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "CLI tool manage work with Driven library",
        subcommands: [
            Generate.self
        ],
        defaultSubcommand: Generate.self
    )
}


Driven.main()
