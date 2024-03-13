//
//  TimelineViewBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 17.12.2023.
//

import SwiftUI

struct TimelineViewBootcamp: View {
    
    @State private var startTime: Date = .now
    
    @State private var paused: Bool = false
    
    var body: some View {
        VStack {
            
            // TimeLineView is updating every 1 second, if we dont use minimumInterval then TimeLineView will update too much times (every milliseconds)
            
            TimelineView(.animation(minimumInterval: 1, paused: paused)) { context in
               // let seconds = Calendar.current.component(.second, from: context.date)
                let seconds = context.date.timeIntervalSince(startTime)
                
                VStack {
                    Text("\(seconds)")
                    Rectangle()
                        .frame(
                            width: Double(5 * seconds),
                            height: 200
                        )
                        .animation(.bouncy, value: seconds)
                }
            }
            
            Button(paused ? "Play" : "Pause") {
                paused.toggle()
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Set") {
                startTime = .now
            }
            .buttonStyle(BorderedButtonStyle())
        }
    }
}

#Preview {
    TimelineViewBootcamp()
}
