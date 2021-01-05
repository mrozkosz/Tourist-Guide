//
//  ImageLoader.swift
//  EstimoteAPP
//
//  Created by Mateusz on 05/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    var urlStringPrewievSize: String?
    var urlStringMediumSize: String?
    var urlStringLargeSize: String?
    var imageCache = ImageCache.getImageFromCache()
    
    init(urlString: String?) {
        self.urlStringPrewievSize = baseUrl+"/images/s480/\(urlString ?? "logo.png")"
        self.urlStringMediumSize = baseUrl+"/images/s720/\(urlString ?? "logo.png")"
        self.urlStringLargeSize = baseUrl+"/images/s1440/\(urlString ?? "logo.png")"
        
        loadImage()
    }
    
    func loadImage() {
        
        if loadImageFromCache() {
            return
        }
        
        loadPreviewImage()
    
    }
    
    func loadImageFromCache() -> Bool {
        guard let imageFromCache = urlStringMediumSize else{
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: imageFromCache) else {
            return false
        }
        
        image = cacheImage
        return true
    }
    
    func loadPreviewImage() {
        guard let urlString = urlStringPrewievSize else {
            return
        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponsePrewiew(data:response:error:))
        task.resume()
    
        loadMediumSizeImage()
    }
    
    func loadMediumSizeImage() {
        guard let urlString = urlStringMediumSize else {
            return
        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    
        loadLargeSizeImage()
    }
    
    func loadLargeSizeImage() {
        guard let urlString = urlStringLargeSize else {
            return
        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponsePrewiew(data:response:error:))
        task.resume()
    }
    
    
    func getImageFromResponsePrewiew(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }

            self.image = loadedImage
        }
    }
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            
            self.imageCache.set(forKey: self.urlStringMediumSize!, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageFromCache() -> ImageCache {
        return imageCache
    }
}


