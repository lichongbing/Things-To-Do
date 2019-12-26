//
//  ResizableTextField.swift
//  CoreDataToDo
//
//  Created by Umayanga Alahakoon on 12/26/19.
//  Copyright © 2019 Umayanga Alahakoon. All rights reserved.
//

import SwiftUI

struct ResizableTextField: View {
    
    @EnvironmentObject var obj : observed
    
    var body: some View {
        VStack {
            
            MultiTextField()
                .frame(height: self.obj.size < 150 ? self.obj.size : 150)
                .padding(10)
                .background(Color.yellow)
                .cornerRadius(10)
            
        }.padding()
    }
}

struct ResizableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ResizableTextField()
    }
}

struct MultiTextField : UIViewRepresentable {
    func makeCoordinator() -> MultiTextField.Coordinator {
        return MultiTextField.Coordinator(parent1: self)
    }
    
    @EnvironmentObject var obj : observed
    
    func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.text = "What do you have to do?"
        view.textColor = UIColor.black.withAlphaComponent(0.35)
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        
        self.obj.size = view.contentSize.height
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>) {
        
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent : MultiTextField
        
        init(parent1 : MultiTextField) {
            
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            
            self.parent.obj.size = textView.contentSize.height
        }
    }
}

class observed : ObservableObject {
    @Published var size : CGFloat = 0
}
