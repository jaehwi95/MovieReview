//
//  View+.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/21/25.
//

import Foundation
import UIKit
import SwiftUI

extension View {
    func scrollToBottomOnKeyboard(proxy: ScrollViewProxy) -> some View {
        ModifiedContent(content: self, modifier: ScrollToBottomOnKeyboardViewModifier(proxy: proxy))
    }
}

private final class KeyboardResponder: ObservableObject {
    public static var shared = KeyboardResponder()
    @Published var height: CGFloat = 0
    
    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardChanged),
            name: UIApplication.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardChanged),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardChanged),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardChanged(notification: Notification) {
        DispatchQueue.main.async {
            if notification.name == UIApplication.keyboardWillHideNotification {
                self.height = 0
            } else {
                self.height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            }
        }
    }
}

private struct ScrollToBottomOnKeyboardViewModifier: ViewModifier {
    @ObservedObject private var keyboard = KeyboardResponder.shared
    var proxy: ScrollViewProxy
    
    func body(content: Content) -> some View {
        content
            .onChange(of: keyboard.height) { oldHeight, newHeight in
                if newHeight > 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut) {
                            proxy.scrollTo("bottom", anchor: .bottom)
                        }
                    }
                }
            }
    }
}
