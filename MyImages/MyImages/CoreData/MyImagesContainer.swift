//
//  MyImagesContainer.swift
//  MyImages
//
//  Created by Serdar Onur KARADAĞ on 11.12.2022.
//

import Foundation
import CoreData

class MyImagesContainer {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MyImagesDataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
