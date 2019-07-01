//
//  DriversLicenseReaderReadFunctions.swift
//  TRETJapanNFCReader
//
//  Created by treastrain on 2019/07/01.
//  Copyright © 2019 treastrain / Tanaka Ryoga. All rights reserved.
//

import CoreNFC

extension DriversLicenseReader {
    
    internal func readCommonData(_ session: NFCTagReaderSession, _ driversLicenseCard: DriversLicenseCard) -> DriversLicenseCard {
        let semaphore = DispatchSemaphore(value: 0)
        var driversLicenseCard = driversLicenseCard
        let tag = driversLicenseCard.tag
        
        self.selectMF(tag: tag) { (responseData, sw1, sw2, error) in
            self.printData(responseData, sw1, sw2)
            
            if let error = error {
                print(error.localizedDescription)
                session.invalidate(errorMessage: "SELECT FILE MF\n\(error.localizedDescription)")
                return
            }
            
            if sw1 != 0x90 {
                session.invalidate(errorMessage: "エラー: ステータス: \(Status(sw1: sw1, sw2: sw2).description)")
                return
            }
            
            self.selectEF(tag: tag, data: [0x2F, 0x01]) { (responseData, sw1, sw2, error) in
                self.printData(responseData, sw1, sw2)
                
                if let error = error {
                    print(error.localizedDescription)
                    session.invalidate(errorMessage: "SELECT FILE EF\n\(error.localizedDescription)")
                    return
                }
                
                if sw1 != 0x90 {
                    session.invalidate(errorMessage: "エラー: ステータス: \(Status(sw1: sw1, sw2: sw2).description)")
                    return
                }
                
                self.readBinary(tag: tag, p1Parameter: 0x00, p2Parameter: 0x00, expectedResponseLength: 30) { (responseData, sw1, sw2, error) in
                    self.printData(responseData, sw1, sw2)
                    
                    if let error = error {
                        print(error.localizedDescription)
                        session.invalidate(errorMessage: "READ BINARY\n\(error.localizedDescription)")
                    }
                    
                    if sw1 != 0x90 {
                        session.invalidate(errorMessage: "エラー: ステータス: \(Status(sw1: sw1, sw2: sw2).description)")
                        return
                    }
                    
                    // デコード
                    let responseData = [UInt8](responseData)
                    
                    let cardIssuerDataTag = responseData[0]
                    let cardIssuerDataLength = responseData[1]
                    let specificationVersionNumberData = responseData[2...4]
                    let issuanceDateData = responseData[5...8]
                    let expirationDateData = responseData[9...12]
                    
                    let preIssuanceDataTag = responseData[13]
                    let preIssuanceDataLength = responseData[14]
                    let cardManufacturerIdentifierData = responseData[15]
                    let cryptographicFunctionIdentifierData = responseData[16]
                    
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.dateFormat = "yyyyMMdd"
                    
                    let specificationVersionNumber = String(data: Data(specificationVersionNumberData), encoding: .shiftJIS) ?? "nil"
                    let issuanceDateString = issuanceDateData.map { (data) -> String in
                        return data.toString()
                        }.joined()
                    let issuanceDate = formatter.date(from: issuanceDateString)!
                    let expirationDateString = expirationDateData.map { (data) -> String in
                        return data.toString()
                        }.joined()
                    let expirationDate = formatter.date(from: expirationDateString)!
                    
                    driversLicenseCard.commonData = DriversLicenseCard.CommonData(specificationVersionNumber: specificationVersionNumber, issuanceDate: issuanceDate, expirationDate: expirationDate, cardManufacturerIdentifier: cardManufacturerIdentifierData, cryptographicFunctionIdentifier: cryptographicFunctionIdentifierData)
                    
                    semaphore.signal()
                }
            }
        }
        
        semaphore.wait()
        return driversLicenseCard
    }
}