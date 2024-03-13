//
//  LoadingComponent.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 08.12.2023.
//

import SwiftUI

class LoadingComponentViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = true
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            
            self.isLoading = false
        }
    }
}

struct LoadingComponent: View {
    
    @StateObject private var viewModel = LoadingComponentViewModel()
    
    let isThrowError: Bool
    
    @State var onSuccess: String? = nil
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack {
                    Text("DATA")
                        .preference(key: SuccessPreferenceKey.self, value: "key")
                    if let onSuccess {
                        Text(onSuccess)
                    }
                }
            }
        }
        .onPreferenceChange(SuccessPreferenceKey.self, perform: { value in
            self.onSuccess = value
        })
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    LoadingComponent(isThrowError: false)
}
