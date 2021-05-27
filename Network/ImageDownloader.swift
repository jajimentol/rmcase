//
//  ImageDownloader.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation
import UIKit

final class ImageDownloader: NSObject {
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    static func downloadImage(from url: URL, completionHandler: @escaping ((UIImage?) -> ())) {
        print("Download Started")
        getData(from: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data, error == nil else { return }
            
            completionHandler(UIImage(data: data))
        }
    }
}
