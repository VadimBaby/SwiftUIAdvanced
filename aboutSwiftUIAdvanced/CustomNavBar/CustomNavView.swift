//
//  CustomNavView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 20.10.2023.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            CustomNavBarContainerView {
                content
            }
            .toolbar(.hidden)
        }
    }
}

#Preview {
    CustomNavView {
        Color.red
    }
}

extension UINavigationController { // now we can drag back our custom nav bar
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
