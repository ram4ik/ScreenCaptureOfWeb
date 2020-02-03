//
//  ContentView.swift
//  ScreenCaptureOfWeb
//
//  Created by ramil on 03.02.2020.
//  Copyright © 2020 com.ri. All rights reserved.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    @State private var urlString = "https://www.apple.com"
    @State private var uiImage: UIImage? = nil
    
    var body: some View {
        VStack {
            WebView(url: URL(string: urlString)!)
            SheetView(uiImage: $uiImage)
        }
    }
}

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct SheetView: View {
    @State private var showTrigger = false
    
    @Binding var uiImage: UIImage?
    
    var body: some View {
        VStack {
            Button("Check Image") {
                self.showTrigger = true
            }
        }.sheet(isPresented: $showTrigger, onDismiss: {
            print("Show Screenshot")
        }) {
            ScreenShot(uiImage: self.$uiImage)
        }
    }
}

struct ScreenShot: View {
    @Environment(\.presentationMode) var presentation
    
    @Binding var uiImage: UIImage?
    
    var body: some View {
        VStack {
            
            if uiImage != nil {
                VStack {
                    Image(uiImage: self.uiImage!)
                }.background(Color.green)
                    .frame(width: 500, height: 700)
            }
            Spacer()
            Button("Close") {
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }.font(.custom("SFProText-Bold", size: 25))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
