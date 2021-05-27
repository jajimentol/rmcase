//
//  API.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation

final class API: NSObject {
    
    static let baseURL = ""
    
    let defaultSession = URLSession(configuration: .default)
    
    func getAllCharacters(page: String, completionHandler: @escaping (ResponseModel) -> Void) {
        if page == "1" {
            getCharactersRequest(url: "https://rickandmortyapi.com/api/character", completionHandler: completionHandler)
        } else {
            getCharactersRequest(url: "https://rickandmortyapi.com/api/character/?page=" + page,
                       completionHandler: completionHandler)
        }
        
    }
    
    func getCharactersRequest(url: String, completionHandler: @escaping (ResponseModel) -> Void) {
        
        let url = URL(string: url)!
            
        let task = defaultSession.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            if let error = error {
                showAlert(message: error.localizedDescription)
            }
            
            if let rsp = try? JSONDecoder().decode(ResponseModel.self, from: data) {
                completionHandler(rsp)
            }
        }

        task.resume()
        }
    
    func getSingleCharacter(id: String, completionHandler: @escaping (Character) -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character/" + id)!
        
        let task = defaultSession.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            if let error = error {
                showAlert(message: error.localizedDescription)
            }
            
            if let rsp = try? JSONDecoder().decode(Character.self, from: data) {
                completionHandler(rsp)
            }
        }

        task.resume()
    }
    
    func getEpisodeNames(ids: [String], completionHandler: @escaping ([Episode]) -> Void) {
        
        var queryUrl = ""
        for item in ids {
            queryUrl = queryUrl + item + ","
        }
        
        queryUrl.removeLast()
        
        let url = URL(string: "https://rickandmortyapi.com/api/episode/" + queryUrl)!
        
        let task = defaultSession.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            if let error = error {
                showAlert(message: error.localizedDescription)
            }
            
            if let rsp = try? JSONDecoder().decode([Episode].self, from: data) {
                completionHandler(rsp)
            }
        }

        task.resume()
        
    }
    
}
