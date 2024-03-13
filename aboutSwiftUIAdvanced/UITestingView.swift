//
//  UITestingView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 01.11.2023.
//

import SwiftUI

class UITestingViewModel: ObservableObject {
    let placeholder: String = "Add your name..."
    
    @Published public var textFieldText: String = ""
    @Published public var currentUserIsSignedIn: Bool
    
    init(currentUserIsSignedIn: Bool) {
        self.currentUserIsSignedIn = currentUserIsSignedIn
    }
    
    func signUpButtonPressed() {
        guard !textFieldText.isEmpty else { return }
        currentUserIsSignedIn = true
    }
}

struct UITestingView: View {
    
    @StateObject private var vm: UITestingViewModel
    
    init(currentUserIsSignedIn: Bool) {
        _vm = StateObject(wrappedValue: UITestingViewModel(currentUserIsSignedIn: currentUserIsSignedIn))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ZStack {
                if vm.currentUserIsSignedIn {
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                } else {
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

#Preview {
    UITestingView(currentUserIsSignedIn: true)
}

extension UITestingView {
    private var signUpLayer: some View {
        VStack {
            TextField(vm.placeholder, text: $vm.textFieldText)
                .font(.headline)
                .padding()
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 10))
                .accessibilityIdentifier("SignUpTextField")
            
            Button(action: {
                withAnimation(.spring()) {
                    vm.signUpButtonPressed()
                }
            }, label: {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .clipShape(.rect(cornerRadius: 10))
            })
            .accessibilityIdentifier("SignUpButton")
        }
        .padding()
    }
}

struct SignedInHomeView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20, content: {
                Button(action: {
                    showAlert = true
                }, label: {
                    Text("Show welcome alert")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .background(Color.red)
                        .clipShape(.rect(cornerRadius: 10))
                })
                .alert("welcome alert", isPresented: $showAlert) {
                    Button("Cancel", role: .cancel) {
                        showAlert = false
                    }
                }
                .accessibilityIdentifier("ShowAlertButton")
                
                NavigationLink {
                    Text("Destination")
                } label: {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 10))
                }
                .accessibilityIdentifier("NavigationLinkToDestination")

            })
            .padding()
            .navigationTitle("Welcome!")
        }
    }
}
