//
//  CardPost.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 15/11/24.
//

import SwiftUI

struct CardPost: View {
    var post: Post
    let maxWidth = UIScreen.main.bounds.width - 32
    
    var body: some View {
        rudoCard
//        persoCard
    }
    
    @ViewBuilder
    var persoCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(post.user)
                .font(.headline)
                .padding([.leading, .top])
            
            Image(post.image)
                .resizable()
                .scaledToFit()
            
            HStack {
                Text("❤️ \(post.likes) Likes")
                Spacer()
                Text(post.description)
                    .lineLimit(2)
            }
            .padding([.horizontal, .bottom])
            .font(.subheadline)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.6), radius: 8, x: 2, y: 2)
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    var rudoCard: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
//                Image("defaultRestaurant")
//                    .resizable()
//                    .scaledToFill()
                
//                Image("image-post")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(maxWidth: maxWidth)
                
                Image("luffy")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: maxWidth, maxHeight: 375)
                    .clipped()

                HStack(spacing: 8) {
                    Image(systemName: "plus")
                    Text("5 fotos")
                }
                .foregroundColor(.black)
                .padding(12)
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Text("4,0")
                        Image(systemName: "star.fill")
                    }
                    Text("Hace 3 horas")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
                Text("El menú de Margarito es una auténtica celebración de los sabores mediterráneos, con productos frescos de temporada y una presentación cuidada al detalle. Las patatas cosas y mas cosas")
                    .lineLimit(4)

                HStack(spacing: 4) {
                    Image("image-post")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(.circle)
                    VStack(alignment: .leading) {
                        Text("Susana Monzó")
                        Text("Restaurante Margarito")
                            .foregroundColor(.gray)
                    }
                }
                Divider()
                HStack(spacing: 16) {
                    Spacer()
                    HStack {
                        Image(systemName: "heart")
                        Text("124")
                    }
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Text("20")
                    }
                }
            }
            .padding(16)
            .frame(maxHeight: .infinity)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.4), radius: 8, x: 2, y: 2)
        .padding(.horizontal, 16)
    }

}

#Preview {
    ListBuilder().build()
}
