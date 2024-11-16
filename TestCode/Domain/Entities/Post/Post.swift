//
//  Post.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 15/11/24.
//

import Foundation

import SwiftUI

struct Post: Identifiable {
    let id = UUID()
    let user: String
    let image: String
    let likes: Int
    let description: String
}

extension Post {
    static let mockPosts = [
        Post(user: "Alice", image: "image-post", likes: 120, description: "Exploring the mountains 🏔️."),
        Post(user: "Bob", image: "image-post", likes: 340, description: "Beach vibes 🏖️."),
        Post(user: "Charlie", image: "image-post", likes: 76, description: "Had an amazing time at the concert 🎶."),
        Post(user: "Diana", image: "image-post", likes: 89, description: "Sunsets are my favorite 🌅."),
        Post(user: "Eve", image: "image-post", likes: 45, description: "Delicious food at this cafe 🍔."),
        Post(user: "Frank", image: "image-post", likes: 231, description: "Adventure awaits 🚵‍♂️."),
        Post(user: "Grace", image: "image-post", likes: 150, description: "Lazy day at home 📚."),
        Post(user: "Hank", image: "image-post", likes: 93, description: "City lights are mesmerizing 🌃."),
        Post(user: "Ivy", image: "image-post", likes: 120, description: "Chasing waterfalls 🌊."),
        Post(user: "Jake", image: "image-post", likes: 205, description: "Road trip to remember 🚗.")
    ]
}
