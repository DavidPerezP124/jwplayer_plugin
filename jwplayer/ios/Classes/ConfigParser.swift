import JWPlayerKit

typealias JSON = [String: Any]

enum ConfigError: Error {
    case invalidConfigName
    case invalidConfigURL
    case invalidConfig
    case invalidDemoConfig
    
    var description: String {
        switch self {
        case .invalidConfigName:
            return "This name does not point to a valid config."
        case .invalidConfig:
            return "This config does not have a valid format."
        case .invalidConfigURL:
            return "This URL is invalid."
        case .invalidDemoConfig:
            return "This demo config does not have a valid format."
        }
    }
}

protocol Tranformable {
    associatedtype TransformerType
    var tranformable: TransformerType { get set }
}

extension Tranformable where TransformerType == JSON {
    func toJWConfig() throws -> JWPlayerConfiguration {
        let data = try self.toJsonData()
        let playerConfig = try JWJSONParser.configFromJSON(data)
        return playerConfig
    }

    func toJsonData() throws -> Data {
        var normalized = tranformable
        if var ads = tranformable["advertising"] as? JSON, let client = ads["client"] as? String {
            switch client {
            case _ where client.contains("vast"):
                ads["client"] = "vast"
            case _ where client.contains("ima"):
                ads["client"] = "googima"
            case _ where client.contains("dai"):
                ads["client"] = "dai"
            default:
                break
            }
            normalized["advertising"] = ads
        }
        let jsonDataResult = try JSONSerialization.data(withJSONObject: normalized as Any, options: [])
        return jsonDataResult
    }
}

extension Tranformable where TransformerType == String {
    func toJsonFromString() throws -> JSON {
        let data = try Data(contentsOf: URL(fileURLWithPath: tranformable), options: .mappedIfSafe)
        let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        guard let json = jsonObj as? JSON else {
            throw ConfigError.invalidConfig
        }
        return json
    }

    func toJSONfromStringifiedJSON() throws -> JSON {
        guard let data = tranformable.data(using: .utf8) else {
            throw ConfigError.invalidConfig
        }
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        guard let validJson = json as? JSON else {
            throw ConfigError.invalidConfig
        }
        return validJson
    }
}

/**
 A generic implementation of the Transformable protocol.
*/
struct ConfigTransfomer<Config>: Tranformable {
    var tranformable: Config
}
