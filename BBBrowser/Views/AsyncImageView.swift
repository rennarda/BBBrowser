//
//  AsyncImageView.swift
//  BBBrowser
//
//  Created by Andrew Rennard on 24/04/2021.
//  Based on code from https://azamsharp.medium.com/asynchronously-loading-images-in-swiftui-3d0452230949

import SwiftUI
import Combine

struct URLImage: View {
    
    @ObservedObject
    private var imageLoader = ImageLoader()
    
    var placeholder: Image
    
    init(url: URL, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        self.imageLoader.load(url: url)
    }
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage).resizable()
        } else {
            return placeholder
        }
    }
}


class ImageLoader: ObservableObject {
    @Published var downloadedImage: UIImage?
    let didChange = PassthroughSubject<ImageLoader?, Never>()
    
    func load(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                     self.didChange.send(nil)
                }
                return
            }
            
            self.downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
        }.resume()
    }
}
