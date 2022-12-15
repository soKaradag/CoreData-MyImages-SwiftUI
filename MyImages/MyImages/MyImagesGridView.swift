//
//  ContentView.swift
//  MyImages
//
//  Created by Serdar Onur KARADAĞ on 11.12.2022.
//

import SwiftUI
import PhotosUI

struct MyImagesGridView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var myImages: FetchedResults<MyImage>
    @StateObject private var imagePicker = ImagePicker()
    @State private var formType: FormType?
    
    
    var body: some View {
        NavigationStack {
            Group{
                if !myImages.isEmpty {
                    ScrollView{
                            ForEach(myImages) {MyImage in
                                VStack(alignment: .leading){
                                    HStack {
                                        Button{
                                            formType = .update(MyImage)
                                        } label: {
                                            VStack{
                                                Image(uiImage: MyImage.uiImage)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100, height: 100)
                                                    .clipped()
                                                    .shadow(radius: 5)
                                            }
                                    }
                                        VStack(alignment: .leading){
                                            Text(MyImage.nameView)
                                            Text(MyImage.commentView)
                                        }
                                        Spacer()
                                    }
                                    .frame(width: 350, height: 150)
                                }
                            }
                        
                    }
                    .padding()
                } else {
                    Text("Select your first image.")
                }
            }
            .navigationTitle("My Images")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker("New Image",
                                 selection: $imagePicker.imageSelection ,
                                 matching: .images , photoLibrary: .shared())
                }
            }
            .onChange(of: imagePicker.uiImage) { newImage in
                if let newImage {
                    formType = .new(newImage)
                }
            }
            .sheet(item: $formType) { $0 }
        }
    }
}

struct MyImagesGridView_Previews: PreviewProvider {
    static var previews: some View {
        MyImagesGridView()
    }
}
