//
//  CustomNavLink.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 20.10.2023.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavBarContainerView {
                destination
            }
            .toolbar(.hidden)
        } label: {
            label
        }

    }
}

#Preview {
    CustomNavView {
        CustomNavLink(destination: Text("HI")) {
            Text("Click")
        }
    }
}
