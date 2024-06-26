//
//  FeliCaSystem.swift
//  TRETJapanNFCReader
//
//  Created by treastrain on 2019/11/09.
//  Copyright © 2019 treastrain / Tanaka Ryoga. All rights reserved.
//

import Foundation

public struct FeliCaSystem: Codable, Equatable {
    public let systemCode: FeliCaSystemCode
    public let idm: String
    public let pmm: String
    public let services: [FeliCaServiceCode : FeliCaBlockData]
    public let cardType: String
    
    public subscript(serviceCode: FeliCaServiceCode) -> FeliCaBlockData? {
        return self.services[serviceCode]
    }
    
    public init(systemCode: FeliCaSystemCode, idm: String, pmm: String, services: [FeliCaServiceCode : FeliCaBlockData], cardType: String) {
        self.systemCode = systemCode
        self.idm = idm
        self.pmm = pmm
        self.services = services
        self.cardType = cardType
    }
    
    public static func == (lhs: FeliCaSystem, rhs: FeliCaSystem) -> Bool {
        return lhs.systemCode == rhs.systemCode &&
            lhs.idm == rhs.idm &&
            lhs.pmm == rhs.pmm &&
            lhs.services == rhs.services
           lhs.cardType == rhs.cardType
    }
}

/*
public struct FeliCaSystem: Codable {
    public let systemCode: FeliCaSystemCode
    public let idm: String
    public var services: [FeliCaServiceCode : [Data]]
    
    public subscript(serviceCode: FeliCaServiceCode) -> [Data]? {
        return self.services[serviceCode]
    }
    
    public init(systemCode: FeliCaSystemCode, idm: String, services: [FeliCaServiceCode : [Data]]) {
        self.systemCode = systemCode
        self.idm = idm
        self.services = services
    }
}
*/
