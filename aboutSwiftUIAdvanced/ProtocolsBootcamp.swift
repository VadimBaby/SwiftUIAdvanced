//
//  ProtocolsBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 23.10.2023.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = Color.blue
    let secondary: Color = Color.white
    let tertiary: Color = Color.gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = Color.red
    let secondary: Color = Color.white
    let tertiary: Color = Color.green
}

protocol ColorThemeProtocol {
    var primary: Color { get } // { get set }
    var secondary: Color { get }
    var tertiary: Color { get }
}

protocol ButtonTextProtocol {
    var textButton: String { get }
}

protocol ButtonPressProtocol {
    func buttonPress()
}

protocol ButtonProtocol: ButtonTextProtocol, ButtonPressProtocol {
    
}

class DefaultDataService: ButtonTextProtocol {
    var textButton: String = "Protocols are awesome"
}

class AlternativeDataService: ButtonTextProtocol, ButtonPressProtocol {
    var textButton: String = "Protocols are lame"
    
    func buttonPress() {
        print("Button pressed")
    }
}

class AnotherDataService: ButtonProtocol {
    var textButton: String = "Bigger even everything"
    
    func buttonPress() {
        print("yeat")
    }
}

struct ProtocolsBootcamp: View {
    
    let colorTheme: ColorThemeProtocol = DefaultColorTheme()
   // let colorTheme: ColorThemeProtocol = AlternativeColorTheme()
    
  //  let dataService1: ButtonTextProtocol = AlternativeDataService()
    let dataService1: ButtonTextProtocol = DefaultDataService()
 //   let dataService2: ButtonPressProtocol = AlternativeDataService()
    let dataService2: ButtonPressProtocol = AnotherDataService()
    
    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(dataService1.textButton)
                .font(.headline)
                .foregroundStyle(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .clipShape(.rect(cornerRadius: 15 ))
                .onTapGesture {
                    dataService2.buttonPress()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp()
}
