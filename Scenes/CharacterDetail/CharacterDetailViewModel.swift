//
//  CharacterDetailViewModel.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation

final class CharacterDetailViewModel: NSObject {
    let api = API()
    
    var character: Character?
    var episodes: [Episode]?
    
    func getCharacter(id: String, completionHandler: @escaping () -> ()) {
        
        api.getSingleCharacter(id: id) { [weak self] character in
            guard let strongSelf = self else { return }
            strongSelf.character = character
            completionHandler()
        }
    }
    
    func getEpisodeNames(completionHandler: @escaping () -> ()) {
        api.getEpisodeNames(ids: (character?.getEpisodeIds())!) { [weak self] (episodes) in
            guard let strongSelf = self else { return }
            strongSelf.episodes = episodes
            completionHandler()
        }
    }
}
