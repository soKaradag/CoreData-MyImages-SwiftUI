//
//  ImagePicker.swift
//  MyImages
//
//  Created by Serdar Onur KARADAĞ on 11.12.2022.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class ImagePicker: ObservableObject {
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            Task {
                try await loadTransferable(from:imageSelection)
            }
        }
    }
    @Published var image: Image?
    @Published var uiImage: UIImage?
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.uiImage = uiImage
                    self.image = Image(uiImage: uiImage)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
