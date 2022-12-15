//
//  MyImagesApp.swift
//  MyImages
//
//  Created by Serdar Onur KARADAĞ on 11.12.2022.
//

import SwiftUI

@main
struct MyImagesApp: App {
    var body: some Scene {
        WindowGroup {
            MyImagesGridView()
                .environment(\.managedObjectContext, MyImagesContainer().persistentContainer.viewContext)
                .onAppear{
                    print(URL.documentsDirectory.path)
                }
        }
    }
}
