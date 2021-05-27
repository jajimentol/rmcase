//
//  Character.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation

struct Character: Codable {
    var name: String
    var imageUrl: String
    var status: String
    var species: String
    var episodes: [String]?
    var gender: String
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageUrl = "image"
        case status = "status"
        case species = "species"
        case episodes = "episode"
        case gender = "gender"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.status = try container.decode(String.self, forKey: .status)
        self.species = try container.decode(String.self, forKey: .species)
        self.episodes = try? container.decode([String].self, forKey: .episodes)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.id = try container.decode(Int.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.imageUrl, forKey: .imageUrl)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.species, forKey: .species)
        try? container.encode(self.episodes, forKey: .episodes)
        try container.encode(self.gender, forKey: .gender)
        try container.encode(self.id, forKey: .id)
    }
    
    func getEpisodeIds() -> [String] {
        var episodeIds: [String] = []
        if let episodes = self.episodes {
            for item in episodes {
                if episodeIds.count > 8 {
                    let id = String(item.suffix(2))
                    episodeIds.append(id)
                } else {
                    let id = String(item.last!)
                    episodeIds.append(id)
                }
            }
        }
        return episodeIds
    }
}
