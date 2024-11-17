//
//  TestProgressBarView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 10/11/24.
//

import SwiftUI


struct TestProgressBarView: View {
    @StateObject var viewModel: TestProgressBarViewModel
    @State var currentStep = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                stepIndicator(totalSteps: 3)
                
                Spacer()
                
                StepContentView(currentStep: currentStep)
                
                Spacer()
                
                StepNavigationView(currentStep: $currentStep, totalSteps: 3)
                    .padding()
            }
        }
    }

    @ViewBuilder
    private func stepIndicator(totalSteps: Int) -> some View {
        VStack {
            Text("Paso \(currentStep) de \(totalSteps)")
                .font(.headline)
                .padding(.bottom, 10)
            
            HStack(spacing: 4) {
                ForEach(1...totalSteps, id: \.self) { step in
                    CustomProgressBarView(step: step, currentStep: $currentStep)
                }
            }
            .padding(0)
        }
    }
}

// StepContentView
struct StepContentView: View {
    let currentStep: Int
    
    var body: some View {
        switch currentStep {
        case 1:
            StepView(stepText: "Contenido de la Vista 1")
        case 2:
            StepView(stepText: "Contenido de la Vista 2")
        case 3:
            StepView(stepText: "Contenido de la Vista 3")
        default:
            EmptyView()
        }
    }
}

// StepNavigationView
struct StepNavigationView: View {
    @Binding var currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        HStack {
            Button("Anterior") {
                withAnimation {
                    if currentStep > 1 {
                        currentStep -= 1
                    }
                }
            }
            .disabled(currentStep == 1)
            
            Spacer()
            
            Button("Siguiente") {
                withAnimation {
                    if currentStep < totalSteps {
                        currentStep += 1
                    }
                }
            }
            .disabled(currentStep == totalSteps)
        }
    }
}

struct StepView: View {
    let stepText: String
    
    var body: some View {
        Text(stepText)
            .font(.title)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding()
    }
}

#Preview {
    TestProgressBarBuilder().build()
}
