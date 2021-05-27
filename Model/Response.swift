//
//  Response.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation

struct ResponseModel: Codable {
    var results: [Character]
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Character].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.results, forKey: .results)
    }
}
