//
//  MyImage+Extension.swift
//  MyImages
//
//  Created by Serdar Onur KARADAĞ on 11.12.2022.
//

import UIKit

extension MyImage {
    var nameView: String {
        name ?? ""
    }
    
    var imageID: String {
        id ?? ""
    }
    
    var commentView: String {
        comment ?? ""
    }
    
    var uiImage: UIImage {
        if !imageID.isEmpty,
           let image = FileManager().retrieveImage(with: imageID) {
            return image
        } else {
            return UIImage(systemName: "photo")!
        }
    }
}
