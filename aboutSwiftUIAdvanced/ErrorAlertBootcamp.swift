//
//  ErrorAlertBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 18.12.2023.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T>(anyValue: Binding<T?>) {
        self.init {
            return anyValue.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                anyValue.wrappedValue = nil
            }
        }

    }
}

protocol AppError {
    var title: String { get }
    var subtitle: String? { get }
    var buttons: AnyView { get }
}

extension View {
    // сюда мы помеж передать любой enum с протоколом AppError
    func addCustomErrorAlert<T: AppError>(error: Binding<T?>) -> some View {
        self
            .alert(error.wrappedValue?.title ?? "ERROR", 
                   isPresented: Binding(anyValue: error),
                   actions: {
                error.wrappedValue?.buttons
        }, message: {
            if let subtitle = error.wrappedValue?.subtitle {
                Text(subtitle)
            }
        })
        
    }
}

struct ErrorAlertBootcamp: View {
    
    @State private var error: MyCustomError? = nil
    
    var body: some View {
        Button("CLICK ME") {
            saveData()
        }
        .addCustomErrorAlert(error: $error)
//        .alert(error?.title ?? "ERROR", isPresented: Binding(anyValue: $error), actions: {
//            error?.buttonsForAlert
//        }, message: {
//            if let subtitle = error?.subtitle {
//                Text(subtitle)
//            }
//        })
    }
    
    enum MyCustomError: Error, LocalizedError, AppError {
        case noInternetConnection
        case dataNotFound(onPressed: () -> Void)
        case urlError(error: Error, onPressed: () -> Void)
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "Check your internet connection and try again."
            case .dataNotFound:
                return "There was an error loading data. Please try again"
            case .urlError(error: let error, onPressed: _):
                return "URL Error: \(error.localizedDescription)"
            }
        }
        
        var title: String {
            switch self {
            case .noInternetConnection:
                return "Bad internet connection"
            case .dataNotFound:
                return "No data"
            case .urlError:
                return "URL Error"
            }
        }
        
        var subtitle: String? {
            switch self {
            case .noInternetConnection:
                return "Check your internet connection and try again."
            case .dataNotFound:
                return "There was an error loading data. Please try again"
            case .urlError:
                return nil
            }
        }
        
        var buttons: AnyView {
            AnyView(buttonsForAlert)
        }
        
        @ViewBuilder var buttonsForAlert: some View {
            switch self {
            case .dataNotFound(onPressed: let action):
                Button("RETRY") {
                    action()
                }
            case .urlError(error: _, onPressed: let action):
                Button("OK") {
                    action()
                }
            default:
                Button("OK") {
                    
                }
            }
        }
    }
    
    private func saveData() {
        let isSuccess = false
        
        if isSuccess {
            
        } else {
            let error: Error = MyCustomError.noInternetConnection
            let urlError: Error = MyCustomError.urlError(error: URLError(.badServerResponse)) {
                print("do something")
            }
            let myError: MyCustomError = .dataNotFound {
                print("Retry")
            }
            
            self.error = myError
        }
    }
}

#Preview {
    ErrorAlertBootcamp()
}
