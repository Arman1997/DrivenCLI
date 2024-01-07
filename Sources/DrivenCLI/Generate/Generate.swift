import ArgumentParser
import Driven
import DeclarativeSwiftSyntax
import Foundation

protocol DrivenView {}

extension Driven {
    struct Generate: ParsableCommand {
        private var config: DrivenConfiguration!
        
        mutating func run() throws {
            let widgetMetadataDecoder = WidgetMetadataDecoder()
            config = try NeighborConfigurationFile().value
            
            print(
                try GeneratedHandler(
                    metadatas: try drivenDeclaredFilePaths(
                        atDirectory: config.inputs
                    ).map {
                        try String(contentsOfFile: $0, encoding: .utf8)
                    }.map {
                        $0.asSyntax.classDeclarations().filter { $0.isSubtype(of: DrivenView.self) }
                    }.flatMap {
                        $0.flatMap {
                            $0.computedVariableDeclarations()
                        }
                    }.map {
                        print($0)
                        return $0.description
                    }
                        .map {
                            try widgetMetadataDecoder.decode(from: $0)
                        }
                ).generate()
            )
            
        }
        
        private func drivenDeclaredFilePaths(atDirectory directoryPath: String) throws -> [String] {
            let fileManager = FileManager.default
            return try fileManager
                .contentsOfDirectory(atPath: directoryPath)
                .filter {
                    $0.hasSuffix(".swift")
                }
                .compactMap {
                    URL(fileURLWithPath: directoryPath).appendingPathComponent($0).path
                }
        }
    }
}
