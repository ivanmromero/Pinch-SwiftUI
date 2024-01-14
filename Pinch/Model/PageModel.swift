//
//  PageModel.swift
//  Pinch
//
//  Created by Ivan Romero on 14/01/2024.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String { "thumb-\(imageName)" }
}
