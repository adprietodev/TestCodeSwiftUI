import SwiftUI

struct TabBarView: View {
    enum Tab {
        case home, menu, order, book, checkOut
    }
    
    @State private var selectedTab: Tab
    
    init(selectedTab: Tab) {
          _selectedTab = State(initialValue: selectedTab)
      }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                switch selectedTab {
                case .home:
                    viewTest(name: "Home")
                case .menu:
                    viewTest(name: "Menu")
                case .order:
                    viewTest(name: "Order")
                case .book:
                    viewTest(name: "Book")
                case .checkOut:
                    viewTest(name: "CheckOut")
                }
                
                HStack {
                    CustomTabItem(icon: "house", title: "Home", tab: .home, selectedTab: $selectedTab)
                    Spacer()
                    CustomTabItem(icon: "square.grid.3x3", title: "Menu", tab: .menu, selectedTab: $selectedTab)
                    Spacer()
                    CustomTabItem(icon: "chart.bar.horizontal.page", title: "Order", tab: .order, selectedTab: $selectedTab)
                    Spacer()
                    CustomTabItem(icon: "book", title: "Book", tab: .book, selectedTab: $selectedTab)
                    Spacer()
                    CustomTabItem(icon: "person", title: "User", tab: .checkOut, selectedTab: $selectedTab)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .background(selectedTab == .menu ? .white : .black)
                .background(.red)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    @ViewBuilder
    func viewTest(name: String) -> some View {
        VStack {
            Text("View Test \(name)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CustomTabItem: View {
    let icon: String
    let title: String
    let tab: TabBarView.Tab
    @Binding var selectedTab: TabBarView.Tab
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(.white)

            
            Text(title)
                .font(.caption)
                .foregroundColor(getTitleColor())
        }
        .padding(.bottom, 26)
        .onTapGesture {
            selectedTab = tab
        }
    }
    
    
    func getTitleColor() -> Color {
        if selectedTab == tab {
            return .red
        } else {
            return selectedTab == .menu ? .black : .white
        }
    }
}

#Preview {
    TabBarView(selectedTab: .home)
}
