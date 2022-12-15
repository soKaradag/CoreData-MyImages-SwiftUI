//
//  FormViewModel.swift
//  MyImages
//
//  Created by Serdar Onur KARADAĞ on 11.12.2022.
//

import UIKit

class FormViewModel: ObservableObject {
    @Published var name = ""
    @Published var uiImage: UIImage
    @Published var comment = ""
    
    var id: String?
    var updating: Bool { id != nil }
    
    init(_ uiImage: UIImage) {
        self.uiImage = uiImage
    }
    
    init(_ myImage: MyImage) {
        name = myImage.nameView
        id = myImage.imageID
        uiImage = myImage.uiImage
        name = myImage.commentView
    }
    
    var incomplate: Bool {
        name.isEmpty || uiImage == UIImage(systemName: "photo")!
    }
}
