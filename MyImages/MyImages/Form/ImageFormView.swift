//
//  ImageFormView.swift
//  MyImages
//
//  Created by Serdar Onur KARADAĞ on 11.12.2022.
//

import SwiftUI
import PhotosUI

struct ImageFormView: View {
    
    @ObservedObject var viewModel: FormViewModel
    @StateObject var imagePicker = ImagePicker()
    @FetchRequest(sortDescriptors: [])
    private var myImages: FetchedResults<MyImage>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack{
                Image(uiImage: viewModel.uiImage)
                    .resizable()
                    .scaledToFit()
                TextField("Image Name", text: $viewModel.name)
                TextField("Comment", text: $viewModel.comment)
                HStack{
                    if viewModel.updating {
                        PhotosPicker("Change Image",
                                     selection: $imagePicker.imageSelection,
                                     matching: .images,
                                     photoLibrary: .shared())
                    }
                    Button {
                        if viewModel.updating {
                            if let id = viewModel.id,
                               let selectedImage = myImages.first(where: {$0.id == id}){
                                selectedImage.name = viewModel.name
                                selectedImage.comment = viewModel.comment
                                FileManager().saveImage(with: id, image: viewModel.uiImage, comment: viewModel.comment)
                                if moc.hasChanges {
                                    try? moc.save()
                                }
                            }
                        } else {
                            let newImage = MyImage(context: moc)
                            newImage.name = viewModel.name
                            newImage.comment = viewModel.comment
                            newImage.id = UUID().uuidString
                            try? moc.save()
                            FileManager().saveImage(with: newImage.imageID, image: viewModel.uiImage, comment: viewModel.comment)
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .disabled(viewModel.incomplate)

                }
                Spacer()
            }
            .padding()
            .navigationTitle(viewModel.updating ? "Update Image" : "New Image")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                if viewModel.updating {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if let selectedImage = myImages.first(where: {$0.id == viewModel.id}) {
                                FileManager().deleteImage(with: selectedImage.imageID)
                                moc.delete(selectedImage)
                                try? moc.save()
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)

                    }
                }
            }
            .onChange(of: imagePicker.uiImage) { newImage in
                if let newImage {
                    viewModel.uiImage = newImage
                }
            }
        }
    }
}

struct ImageFormView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFormView(viewModel: FormViewModel(UIImage(systemName: "photo")!))
    }
}
