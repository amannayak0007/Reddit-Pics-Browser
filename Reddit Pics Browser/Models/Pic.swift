//
//  Pic.swift
//  Reddit Pics Browser
//
//  Created by AMAN JAIN on 26/06/22.
//

import Foundation

// MARK: - Pics
struct Pic: Codable {
    let data: PicsData
}

// MARK: - PicsData
struct PicsData: Codable {
    let children: [Child]
}

// MARK: - Child
struct Child: Codable {
    let data: ChildData
}

// MARK: - ChildData
struct ChildData: Codable {
    var title: String
    var created: Double
    var author: String
    var url: String
    var isFavourite: Bool?
}
