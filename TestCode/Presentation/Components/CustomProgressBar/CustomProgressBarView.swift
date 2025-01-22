//
//  CustomProgressBar.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 16/11/24.
//

import SwiftUI

struct CustomProgressBarView: View {
    var step: Int
    @Binding var currentStep: Int
    @State private var barState: BarState = .collapsing
    @State private var weigthMainBar: CGFloat = 0
    
    enum BarState {
        case idle
        case expanding
        case collapsing
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 4)
                .clipShape(RoundedCornersShape.forStep(step, color: .white))
                .background(
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            weigthMainBar = geo.size.width - 15
                        }
                    }
                )

            Rectangle()
                .fill(Color.black)
                .frame(width: widthForState(), height: 4)
                .clipShape(RoundedCornersShape.forStep(step, color: .black))
                .onAppear {
                    updateBarState()
                }
                .onChange(of: currentStep) {
                    updateBarState()
                }
        }
    }
    
    private func widthForState() -> CGFloat {
        switch barState {
        case .expanding:
            return weigthMainBar
        case .collapsing:
            return 0
        case .idle:
            return weigthMainBar + 15
        }
    }
    
    private func updateBarState() {
        if step == currentStep {
            barState = .expanding
        } else if step < currentStep {
            barState = .idle
        } else  {
            barState = .collapsing
        }
    }
}

struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
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

#Preview {
    TestProgressBarBuilder().build()
}
