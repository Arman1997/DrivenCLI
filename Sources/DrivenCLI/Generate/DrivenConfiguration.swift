import Foundation
import Yams

struct DrivenConfiguration: Codable {
    let inputs: String
    let output: String
    let template: String
    let remote: String
}
