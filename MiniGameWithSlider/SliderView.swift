//
//  SliderView.swift
//  MiniGameWithSlider
//
//  Created by Клоун on 19.09.2022.
//

import SwiftUI

struct SliderView: View, UIViewRepresentable {
    @Binding var value: Double
    @Binding var destinationValue: Int
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.value = Float(value)
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged), for: .valueChanged)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.thumbTintColor = .red.withAlphaComponent(0.3)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value, destinationValue: $destinationValue)
    }
}

extension SliderView {
    class Coordinator: NSObject {
        @Binding var value: Double
        @Binding var destinationValue: Int
        
        init(value: Binding<Double>, destinationValue: Binding<Int>) {
            _value = value
            _destinationValue = destinationValue
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            value = Double(sender.value)
            sender.thumbTintColor = .red.withAlphaComponent(computeOpacity())
        }
        
        private func computeOpacity() -> CGFloat {
            let difference = CGFloat(abs(destinationValue - lround(value))) / 100
            return 1 - difference
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(value: .constant(100), destinationValue: .constant(50))
    }
}
