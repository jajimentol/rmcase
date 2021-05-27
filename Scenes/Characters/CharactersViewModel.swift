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
    
    func getCharacters(completionHandler: @escaping () -> ()) {
        
        api.getAllCharacters { response in
            
            self.characterList.append(contentsOf: response.results)
            completionHandler()
        }
    }
}
