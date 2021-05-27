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
    
    func getAllCharacters(page: Int = 0, completionHandler: @escaping (ResponseModel) -> Void) {
        if page == 0 {
            getRequest(url: "https://rickandmortyapi.com/api/character", completionHandler: completionHandler)
        } else {
            getRequest(url: "https://rickandmortyapi.com/api/character/?page" + String(format: "%d", page),
                       completionHandler: completionHandler)
        }
        
    }
    
    func getRequest(url: String, completionHandler: @escaping (ResponseModel) -> Void) {
        
        let url = URL(string: url)!
            
        let task = defaultSession.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let rsp = try? JSONDecoder().decode(ResponseModel.self, from: data) {
                completionHandler(rsp)
            }
        }

        task.resume()
        }
    
}
