//
//  Profile.swift
//  Abjd Test
//
//  Created by noyer altamimi on 09/04/1443 AH.
//

import UIKit

class profile {
    
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        
        let url = imageURL(forKey: key)

      
        if let data = image.jpegData(compressionQuality: 0.7) {
     
            try? data.write(to: url)
        }
    }

    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }

        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }

        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }

    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Not able to remove this image from disk: \(error)")
        }
    }
    
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories =
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
    
}

