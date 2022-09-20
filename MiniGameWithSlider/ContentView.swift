//
//  ContentView.swift
//  MiniGameWithSlider
//
//  Created by Клоун on 19.09.2022.
//

import SwiftUI

struct ContentView: View {
    @State var sliderValue = 0.0
    @State var randomValue = Int.random(in: 0...100)
    @State var alertIsPresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Подвиньте слайдер как можно ближе к: \(randomValue)")
            SliderView(value: $sliderValue, destinationValue: $randomValue)
            Button("Получить результат") {
                alertIsPresented = true
            }
            .alert("Результат", isPresented: $alertIsPresented) {} message: {
                Text("Ваш результат - \(computeScore())")
            }
            
            Button("Начать заново")  {
                randomValue = Int.random(in: 0...100)
            }
        }
        .padding()
    }
    
    private func computeScore() -> Int {
        let difference = abs(randomValue - lround(sliderValue))
        return 100 - difference
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
