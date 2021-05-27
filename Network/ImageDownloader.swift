//
//  ImageDownloader.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation
import UIKit

final class ImageDownloader: NSObject {
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completionHandler: @escaping ((UIImage?) -> ())) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.getData(from: url) { data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let data = data, error == nil else { return }
                
                if let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: url as AnyObject)
                    completionHandler(image)
                }
            }
        }
    }
}
