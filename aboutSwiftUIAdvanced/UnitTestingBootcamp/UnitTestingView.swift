//
//  UnitTestingView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 30.10.2023.
//

import SwiftUI

struct UnitTestingView: View {
    
    @StateObject private var viewModel: UnitTestingViewModel
    
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(viewModel.isPremium.description)
    }
}

#Preview {
    UnitTestingView(isPremium: true)
}
