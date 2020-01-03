//
//  FeliCaPMm.swift
//  TRETJapanNFCReader
//
//  Created by treastrain on 2020/01/03.
//  Copyright © 2020 treastrain / Tanaka Ryoga. All rights reserved.
//

import Foundation

public struct FeliCaPMm: Codable {
    public let data: Data
    
    public init(data: Data) {
        self.data = data
    }
}
