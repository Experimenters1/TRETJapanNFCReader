//
//  Extensions.swift
//  TRETJapanNFCReader
//
//  Created by Huy vu on 2/7/24.
//  Copyright © 2024 treastrain / Tanaka Ryoga. All rights reserved.
//

import Foundation

public extension Data {
    func toInt(from indices: Int...) -> Int {
        let balanceBytes = indices.map { self[$0] }
        
        guard balanceBytes.count > 0 else {
            fatalError("IllegalArgumentException")
        }
        
        if balanceBytes.count == 1 {
            return Int(balanceBytes[0] & 0xFF)
        }
        if balanceBytes.count == 2 {
            var i = 0
            i |= Int(balanceBytes[0] & 0xFF)
            i <<= 8
            i |= Int(balanceBytes[1] & 0xFF)
            return i
        }
        if balanceBytes.count == 3 {
            var i = 0
            i |= Int(balanceBytes[0] & 0xFF)
            i <<= 8
            i |= Int(balanceBytes[1] & 0xFF)
            i <<= 8
            i |= Int(balanceBytes[2] & 0xFF)
            return i
        }
        
        return balanceBytes.withUnsafeBufferPointer {
            $0.baseAddress!.withMemoryRebound(to: Int32.self, capacity: 1) {
                Int(CFSwapInt32BigToHost(UInt32($0.pointee)))
            }
        }
    }
}
