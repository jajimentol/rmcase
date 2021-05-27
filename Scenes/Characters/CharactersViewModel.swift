//
//  CharactersViewModel.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation

final class CharactersViewModel: NSObject {
    
    let api = API()
    
    var characterList: [Character] = []
    var nextPage = 1
    
    func getCharacters(completionHandler: @escaping (Bool) -> ()) {
        
        api.getAllCharacters(page: String(format: "%d", nextPage)) { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.characterList.append(contentsOf: response.results)
            strongSelf.nextPage += 1
            completionHandler(strongSelf.characterList.isEmpty)
        }
    }
}
