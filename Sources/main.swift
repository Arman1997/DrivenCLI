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

extension Driven {
    struct Generate: ParsableCommand {
        
        @Argument(help: "Project path for which to run Driven")
        var inputPath: String
        
        @Argument(help: "Output path where generated handlers will be")
        var outputPath: String = "/Users/armangalstyan/Projects/driven-go-template/metadata_provider/metadata_provider.go"
        
        mutating func run() throws {
            let drivenViewsPaths = try step("Finding files with Driven view declaration") {
                findFilesWithCommentDriven(inDirectory: inputPath)
            }
            
            let drivenViewsContents = try step("Fetching contents of those files") {
                try drivenViewsPaths.compactMap { try String(contentsOfFile: $0) }
            }
            
            
            let metadatas = try step("Decoding metadatas") {
                let metadataDecoder = WidgetMetadataDecoder()
                return try drivenViewsContents.map { try  metadataDecoder.decode(from: $0) }
            }
            
            debugPrint(metadatas)
        }
    }
}

private extension Driven {
    static func step<Output>(_ outputMessage: String, execute: () throws -> Output) throws -> Output {
        print(outputMessage)
        return try execute()
    }
    
    static func findFilesWithCommentDriven(inDirectory directory: String) -> [String] {
        var matchingFiles: [String] = []

        let fileManager = FileManager.default

        do {
            let fileURLs = try fileManager.contentsOfDirectory(atPath: directory)

            for fileURL in fileURLs {
                let filePath = (directory as NSString).appendingPathComponent(fileURL)
                if let fileContent = try? String(contentsOfFile: filePath) {
                    if fileContent.contains("// Driven") {
                        matchingFiles.append(filePath)
                    }
                }
            }
        } catch {
            print("Error reading directory: \(error)")
        }

        return matchingFiles
    }
}


Driven.main()
