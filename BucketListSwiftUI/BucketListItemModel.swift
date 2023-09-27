//
//  BucketListItemModel.swift
//  BucketListSwiftUI
//
//  Created by Sergio Mascarpone on 27.09.23.
//

import Foundation

struct BucketListItemModel: Identifiable, Equatable, Codable {
    var name: String
    var id = UUID()
    var isCompleted: Bool = false
}
