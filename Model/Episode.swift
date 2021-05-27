//
//  Episode.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation

struct Episode: Codable {
    var name: String
    var episode: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case episode = "episode"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.episode = try container.decode(String.self, forKey: .episode)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.episode, forKey: .episode)
    }
    
    func getEpisodeName() -> String {
        return name + " " + episode
    }
}
