//
//  CardType.swift
//  TRETJapanNFCReader
//
//  Created by Huy vu on 26/6/24.
//  Copyright © 2024 treastrain / Tanaka Ryoga. All rights reserved.
//

import Foundation

public struct CardType : Codable, Equatable {
    public let cardType: String
    
    
    public init( cardType: String) {
        self.cardType = cardType
    }
}
