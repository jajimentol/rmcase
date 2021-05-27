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
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageUrl = "image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.imageUrl, forKey: .imageUrl)
    }
}
