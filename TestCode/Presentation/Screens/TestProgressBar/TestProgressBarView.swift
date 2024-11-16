//
//  TestProgressBarView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 10/11/24.
//

import SwiftUI

struct TestProgressBarView: View {
    @StateObject var viewModel: TestProgressBarViewModel
    @State private var currentStep = 1
    @State private var navigateToCardView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                StepIndicator(currentStep: currentStep, totalSteps: 3)
                
                Spacer()
                
                StepContentView(currentStep: currentStep)
                
                Spacer()
                
                Button("Go card", action: {
                    navigateToCardView = true
                })
                
                StepNavigationView(currentStep: $currentStep, totalSteps: 3)
                    .padding()
            }
            .navigationDestination(isPresented: $navigateToCardView) {
                ListBuilder().build()
            }
        }
    }
}

// StepIndicator
struct StepIndicator: View {
    let currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        VStack {
            Text("Paso \(currentStep) de \(totalSteps)")
                .font(.headline)
                .padding(.bottom, 10)
            
            HStack(spacing: 4) {
                ForEach(1...totalSteps, id: \.self) { step in
                    ProgressStepView(step: step, currentStep: currentStep)
                }
            }
            .padding(0)
        }
    }
}

// ProgressStepView
struct ProgressStepView: View {
    let step: Int
    let currentStep: Int
    @State private var animateCurrentBar = false
    @State private var animateNextBar = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 4)
                .clipShape(RoundedCornersShape.forStep(step, color: .white))
            
            Rectangle()
                .fill(Color.black)
                .frame(width: widthForStep(), height: 4)
                .clipShape(RoundedCornersShape.forStep(step, color: .black))
                .animation(.easeInOut(duration: 0.5), value: animateCurrentBar)
                .onAppear {
                    if step == currentStep {
                        animateCurrentBar = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            animateNextBar = true
                            animateCurrentBar = false
                        }
                    }
                }
                .onChange(of: currentStep) { newStep in
                    if newStep == step {
                        animateCurrentBar = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            animateNextBar = true
                            animateCurrentBar = false
                        }
                    } else {
                        animateCurrentBar = false
                    }
                }
        }
    }
    
    private func widthForStep() -> CGFloat {
        if step < currentStep {
            return .infinity
        } else if step == currentStep {
            return animateNextBar ? 105 : 0
        } else {
            return 0
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

// RoundedCornersShape
struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
    static func forStep(_ step: Int, color: Color) -> RoundedCornersShape {
        switch step {
        case 1:
            return RoundedCornersShape(corners: [.topRight, .bottomRight], radius: 20)
        case 2:
            return RoundedCornersShape(corners: [.allCorners], radius: 20)
        case 3:
            if color == .black {
                return RoundedCornersShape(corners: [.allCorners], radius: 20)
            } else {
                return RoundedCornersShape(corners: [.topLeft, .bottomLeft], radius: 20)
            }
        default:
            return RoundedCornersShape(corners: [], radius: 0)
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
