//
//  CustomTextField.swift
//  appstore
//
//  Created by jh_song on 2022/03/19.
//

import SwiftUI
struct CustomTextField: UIViewRepresentable {
    let label: String
    @Binding var text: String
    
    var focusable: Binding<[Bool]>? = nil
    var isSecureTextEntry: Binding<Bool>? = nil
    
    var returnKeyType: UIReturnKeyType = .default
    var autocapitalizationType: UITextAutocapitalizationType = .none
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    
    var tag: Int? = nil
    var textalign:NSTextAlignment = .left
//    var inputAccessoryView: UIToolbar? = nil
    var onEditing:((Bool)->())? = nil
    var onCommit: (() -> Void)? = nil
    var isFirstResponder: Bool = false
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = label
        
        
        textField.autocapitalizationType = autocapitalizationType
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType

        if keyboardType == .numberPad{
            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
            toolBar.items = [flexButton,doneButton]
            toolBar.setItems([flexButton,doneButton], animated: true)
            textField.inputAccessoryView = toolBar
            
        }
        textField.isSecureTextEntry = isSecureTextEntry?.wrappedValue ?? false
        textField.textContentType = textContentType
        textField.textAlignment = textalign
        
        if let tag = tag {
            textField.tag = tag
        }
        
//        textField.inputAccessoryView = inputAccessoryView
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
        
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.isSecureTextEntry = isSecureTextEntry?.wrappedValue ?? false
        
        if let focusable = focusable?.wrappedValue {
            var resignResponder = true
            
            for (index, focused) in focusable.enumerated() {
                if uiView.tag == index && focused {
                    uiView.becomeFirstResponder()
                    resignResponder = false
                    break
                }
            }
            
            if resignResponder {
                uiView.resignFirstResponder()
            }
        }
        
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UITextFieldDelegate {
        let control: CustomTextField
        var didBecomeFirstResponder = false
        init(_ control: CustomTextField) {
            self.control = control
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if control.onEditing != nil{
                control.onEditing!(true)
            }
            guard var focusable = control.focusable?.wrappedValue else { return }
            
            for i in 0...(focusable.count - 1) {
                focusable[i] = (textField.tag == i)
            }
            DispatchQueue.main.async {
                self.control.focusable?.wrappedValue = focusable
            }
            
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard var focusable = control.focusable?.wrappedValue else {
                textField.resignFirstResponder()
                return true
            }
            
            for i in 0...(focusable.count - 1) {
                focusable[i] = (textField.tag + 1 == i)
            }
            
            control.focusable?.wrappedValue = focusable
            
            if textField.tag == focusable.count - 1 {
                textField.resignFirstResponder()
            }
            
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if control.onEditing != nil
            {
                control.onEditing!(false)
            }
            control.onCommit?()
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            control.text = textField.text ?? ""
        }
    }
}

extension  UITextField {
   @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
      self.resignFirstResponder()
   }
}
