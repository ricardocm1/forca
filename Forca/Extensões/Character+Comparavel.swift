//
//  Character+Comparavel.swift
//  Forca
//
//  Created by Ricardo Carra Marsilio on 10/10/20.
//

import Foundation

extension Character {
    var comparavel: String {
        self.uppercased().folding(options: .diacriticInsensitive, locale: .current)
    }
}
