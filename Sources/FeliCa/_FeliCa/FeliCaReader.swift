//
//  FeliCaReader.swift
//  TRETJapanNFCReader
//
//  Created by treastrain on 2019/08/21.
//  Copyright © 2019 treastrain / Tanaka Ryoga. All rights reserved.
//

#if os(iOS)
import UIKit
import CoreNFC
#if canImport(TRETJapanNFCReader_Core)
import TRETJapanNFCReader_Core
#endif

@available(iOS 13.0, *)
open class FeliCaReader: JapanNFCReader {
    
    public let delegate: FeliCaReaderSessionDelegate?
    public private(set) var systemCodes: [FeliCaSystemCode] = []
    public private(set) var serviceCodes: [FeliCaSystemCode: [(serviceCode: FeliCaServiceCode, numberOfBlock: Int)]] = [:]
    
    
   
    
    private init() {
        fatalError()
    }
    
    /// FeliCaReader を初期化する
    /// - Parameter delegate: FeliCaReaderSessionDelegate
    public init(delegate: FeliCaReaderSessionDelegate) {
        self.delegate = delegate
        super.init(delegate: delegate)
    }
    
    public func readWithoutEncryption(parameters: [FeliCaReadWithoutEncryptionCommandParameter]) {
        self.set(parameters: parameters)
        self.beginScanning()
    }
    
    public func set(parameters: [FeliCaReadWithoutEncryptionCommandParameter]) {
        self.systemCodes.removeAll()
        self.serviceCodes.removeAll()
        for parameter in parameters {
            if self.systemCodes.contains(parameter.systemCode) {
                self.serviceCodes[parameter.systemCode]?.append((serviceCode: parameter.serviceCode, numberOfBlock: parameter.numberOfBlock))
            } else {
                self.serviceCodes[parameter.systemCode] = [(serviceCode: parameter.serviceCode, numberOfBlock: parameter.numberOfBlock)]
                self.systemCodes.append(parameter.systemCode)
            }
        }
    }
    
    open func beginScanning() {
        guard self.checkReadingAvailable() else {
            print("""
                ------------------------------------------------------------
                【FeliCa カードを読み取るには】
                FeliCa カードを読み取るには、開発している iOS Application の Info.plist に "ISO18092 system codes for NFC Tag Reader Session (com.apple.developer.nfc.readersession.felica.systemcodes)" を追加します。ワイルドカードは使用できません。ISO18092 system codes for NFC Tag Reader Session にシステムコードを追加します。
                ------------------------------------------------------------
            """)
            return
        }
        
        self.session = NFCTagReaderSession(
            pollingOption: [.iso18092, .iso14443, .iso15693],
            delegate: self
        )
        self.session?.alertMessage = Localized.nfcReaderSessionAlertMessage.string()
        self.session?.begin()
    }

    
    open override func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        if let readerError = error as? NFCReaderError {
            if readerError.code == .readerSessionInvalidationErrorUserCanceled {
                print("5fb4bf56d1b56f1b56f1b56fd1b56fdb1fdb1fd61bdf54545%fvhdjhvjd bo huy")
            }
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                print("""
                    ------------------------------------------------------------
                    【FeliCa カードを読み取るには】
                    FeliCa カードを読み取るには、開発している iOS Application の Info.plist に "ISO18092 system codes for NFC Tag Reader Session (com.apple.developer.nfc.readersession.felica.systemcodes)" を追加します。ワイルドカードは使用できません。ISO18092 system codes for NFC Tag Reader Session にシステムコードを追加します。
                    ------------------------------------------------------------
                """)
            }
        }
        self.delegate?.japanNFCReaderSession(didInvalidateWithError: error)
        print("5fb4bf56d1b56f1b56f1b56fd1b56fdb1fdb1fd61bdf54545%fvhdjhvjd bo huy con huy")
    }
    
    
    
    
    
    open override func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        if tags.count > 1 {
            let retryInterval = DispatchTimeInterval.milliseconds(1000)
            session.alertMessage = Localized.nfcTagReaderSessionDidDetectTagsMoreThan1TagIsDetectedMessage.string()
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
                session.alertMessage = Localized.nfcReaderSessionAlertMessage.string()
            })
            return
        }
        
        let tag = tags.first!
        session.connect(to: tag) { (error) in
            if nil != error {
                session.invalidate(errorMessage: Localized.nfcTagReaderSessionConnectErrorMessage.string())
                return
            }
            
            switch tag {
            case .feliCa(let feliCaTag):
                if self.shouldReadFeliCaTag(feliCaTag) {
                    session.alertMessage = Localized.nfcTagReaderSessionReadingMessage.string()
                    DispatchQueue(label: "TRETJPNRFeliCaReader", qos: .default).async {
                        self.feliCaTagReaderSessionReadWithoutEncryption(session, feliCaTag: feliCaTag)
                    }
                }else{
                    self.check_IC_CardReaderSession()
                    session.invalidate(errorMessage: Localized.nfcTagReaderSessionConnectErrorMessage.string())
                }
                
            case .iso7816, .iso15693,.miFare:
                self.check_IC_CardReaderSession()
                session.alertMessage = Localized.nfcTagReaderSessionDoneMessage.string()
                session.invalidate()
                
            default:
                let retryInterval = DispatchTimeInterval.milliseconds(1000)
                session.alertMessage = Localized.nfcTagReaderSessionDifferentTagTypeErrorMessage.string()
                DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                    session.restartPolling()
                    session.alertMessage = Localized.nfcReaderSessionAlertMessage.string()
                })
            }
        }
    }

    
   
    
    
    
    open func shouldReadFeliCaTag(_ feliCaTag: NFCFeliCaTag) -> Bool {
        // Kiểm tra nếu có dữ liệu để đọc từ thẻ FeliCa
        for targetSystemCode in self.systemCodes {
            let (pmm, systemCode, _) = feliCaTag.polling(systemCode: targetSystemCode.bigEndian.data, requestCode: .systemCode, timeSlot: .max1)
            if targetSystemCode.bigEndian.data == systemCode {
                return true
            }
        }
        return false
    }

    
   
    

    
    open func check_IC_CardReaderSession(){
        self.delegate?.check_IC_CardReaderSession()
    }
    
    open func feliCaTagReaderSessionReadWithoutEncryption(_ session: NFCTagReaderSession, feliCaTag: NFCFeliCaTag) {
        var feliCaData: FeliCaData = [:]
        var pollingErrors: [FeliCaSystemCode : Error?] = [:]
        var readErrors: [FeliCaSystemCode : [FeliCaServiceCode : Error]] = [:]
        
        for targetSystemCode in self.systemCodes {
            var currentPMm = Data()
            if feliCaData[targetSystemCode] == nil {
                let (pmm, systemCode, error) = feliCaTag.polling(systemCode: targetSystemCode.bigEndian.data, requestCode: .systemCode, timeSlot: .max1)
                if targetSystemCode.bigEndian.data != systemCode {
                    feliCaData[targetSystemCode] = FeliCaSystem(systemCode: targetSystemCode, idm: "", pmm: pmm.hexString, services: [:])
                    pollingErrors[targetSystemCode] = error
                    continue
                } else {
                    currentPMm = pmm
                }
            }
            
            var services: [FeliCaServiceCode : FeliCaBlockData] = [:]
            let serviceCodeData = self.serviceCodes[targetSystemCode]!
            for (serviceCode, numberOfBlock) in serviceCodeData {
                let blockList = (0..<numberOfBlock).map { (block) -> Data in
                    Data([0x80, UInt8(block)])
                }
                
                print()
                print("vsfjbjfnbjfbjkcusbnjfnjbnbjnbjnbjxnbxn : ",blockList)
                print()
                let (status1, status2, blockData, error) = feliCaTag.readWithoutEncryption36(serviceCode: serviceCode.data, blockList: blockList)
                services[serviceCode] = FeliCaBlockData(status1: status1, status2: status2, blockData: blockData)
                if let error = error {
                    if readErrors[targetSystemCode] == nil {
                        readErrors[targetSystemCode] = [serviceCode : error]
                    } else {
                        readErrors[targetSystemCode]![serviceCode] = error
                    }
                }
            }
            
            feliCaData[targetSystemCode] = FeliCaSystem(systemCode: targetSystemCode, idm: feliCaTag.currentIDm.hexString, pmm: currentPMm.hexString, services: services)
        }
        
        session.alertMessage = Localized.nfcTagReaderSessionDoneMessage.string()
        session.invalidate()
        self.feliCaReaderSession(
            didRead: feliCaData,
            pollingErrors: pollingErrors.isEmpty ? nil : pollingErrors,
            readErrors: readErrors.isEmpty ? nil : readErrors
        )
    }
    
    open func feliCaReaderSession(didRead feliCaData: FeliCaData, pollingErrors: [FeliCaSystemCode : Error?]?, readErrors: [FeliCaSystemCode : [FeliCaServiceCode : Error]]?) {
        self.delegate?.feliCaReaderSession(didRead: feliCaData, pollingErrors: pollingErrors, readErrors: readErrors)
        print("Sam yeu oi dfvfsdvfvfdvfvfvfvsdfv")
    }
    
    @available(*, unavailable)
    public func readWithoutEncryption(session: NFCTagReaderSession, tag: NFCFeliCaTag, serviceCode: FeliCaServiceCode, blocks: Int) -> [Data]? {
        return nil
    }
}

@available(iOS 13.0, *)
@available(*, unavailable)
public typealias FeliCaReaderViewController = UIViewController & FeliCaReaderSessionDelegate

#endif
