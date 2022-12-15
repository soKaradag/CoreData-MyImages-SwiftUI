//
//  FormType.swift
//  MyImages
//
//  Created by Serdar Onur KARADAĞ on 11.12.2022.
//

import SwiftUI

enum FormType: Identifiable, View {
    case new(UIImage)
    case update(MyImage)
    
    var id: String {
        switch self {
        case.new:
            return "new"
        case.update:
            return "update"
        }
    }
    
    var body: some View{
        switch self {
        case.new(let uiImage):
            return ImageFormView(viewModel: FormViewModel(uiImage))
        case.update(let myImage):
            return ImageFormView(viewModel: FormViewModel(myImage))
        }
    }
    
    
}
