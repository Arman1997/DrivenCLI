import Foundation
import Yams

enum DrivenCLIError: Error {
    case failedLoadDirectory
    case configurationFileDoNotExist
    case configurationFileDecodeFailed
    
}

struct NeighborConfigurationFile {
    private let fileName: String = "DrivenConfig.yml"
    let value: DrivenConfiguration
    
    
    init() throws {
        guard let executablePath = Bundle.main.executablePath else {
            throw DrivenCLIError.failedLoadDirectory
        }

        let executableDirectory = URL(fileURLWithPath: executablePath).deletingLastPathComponent()
        let configFilePath = executableDirectory.appendingPathComponent(fileName)
        
        guard let configFileContent = FileManager.default.contents(atPath: configFilePath.path) else {
            throw DrivenCLIError.configurationFileDoNotExist
        }
        
        do {
            value = try YAMLDecoder().decode(DrivenConfiguration.self, from: configFileContent)
        } catch {
            throw DrivenCLIError.configurationFileDecodeFailed
        }
    }
}
