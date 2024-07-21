# 🏎️ Road to TRETNFCKit
We are moving away from the pattern of delegation and are being reborn as something that can take advantage of Swift Concurrency.
Please refer to this branch: [`tretnfckit-main`](https://github.com/treastrain/TRETJapanNFCReader/tree/tretnfckit-main)

![](TRETJapanNFCReader.png)

# TRETJapanNFCReader
日本のNFCカード向けリーダーライブラリ / NFC Reader for Japanese NFC Cards for iOS etc.


[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/treastrain/TRETJapanNFCReader/blob/master/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/treastrain/TRETJapanNFCReader)](https://github.com/treastrain/TRETJapanNFCReader/stargazers)
![Platform: iOS|watchOS|tvOS|macOS](https://img.shields.io/badge/Platform-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20macOS-lightgrey.svg)
![Swift: 5.2](https://img.shields.io/badge/Swift-5.2-orange.svg)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/treastrain/TRETJapanNFCReader)
[![CocoaPods](https://img.shields.io/cocoapods/v/TRETJapanNFCReader?label=CocoaPods)](https://cocoapods.org/pods/TRETJapanNFCReader)

Support: [![Twitter: @JapanNFCReader](https://img.shields.io/twitter/follow/JapanNFCReader?label=%40JapanNFCReader&style=social)](https://twitter.com/JapanNFCReader)
Developer [![Twitter: @treastrain](https://img.shields.io/twitter/follow/treastrain?label=%40treastrain&style=social)](https://twitter.com/treastrain)

Suica、PASMOなどの交通系ICカード、楽天Edy、nanaco、WAON などの電子マネーカード、運転免許証、マイナンバーカードの読み取り

## 対応 OS / Supported OS
- iOS 9.3 以降
- watchOS 2.0 以降
- tvOS 9.2 以降
- macOS 10.9 以降

※ NFCカードの読み取りは iOS 13.0 以降で対応するデバイスで使用可能。


## 対応 NFC カード / Supported NFC card
### NFC-B (Type-B)
- [x] 運転免許証
- 警察庁交通局運転免許課による「運転免許証及び運転免許証作成システム等仕様書（仕様書バージョン番号:008）」に対応
- 共通データ要素（MF/EF01）、暗証番号(PIN)設定（MF/EF02）の読み取り、暗証番号1による認証、記載事項(本籍除く)（DF1/EF01）写真（DF2/EF01）まで実装済み
- [x] マイナンバーカード（個人番号カード、Individual Number Card）
- ICカード種別情報（JPKI_CardType）、マイナンバーの読み取りまで実装済み

### NFC-F (Type-F, FeliCa)
IDm と System Code の表示
- [x] 0003: 交通系ICカード (Suica, ICOCA, Kitaca, PASMO, TOICA, manaca, PiTaPa, SUGOCA, nimoca, はやかけん, icsca, ...etc.)
    - 残高の読み取りと表示
    - 利用履歴、改札入出場履歴、SF入場情報の読み取り
- [x] 80DE: IruCa
    - 残高の読み取りと表示
    - 利用履歴、改札入出場履歴、SF入場情報の読み取り
- [x] 8592: PASPY
    - 残高の読み取りと表示
    - 利用履歴、改札入出場履歴、SF入場情報の読み取り
- [x] 865E: SAPICA
    - 残高の読み取りと表示
    - 利用履歴、改札入出場履歴、SF入場情報の読み取り
- [x] 8FC1: OKICA
    - 残高の読み取りと表示
    - 利用履歴、改札入出場履歴、SF入場情報の読み取り
- [x] 8B5D: りゅーと
    - 残高の読み取りと表示
    - 利用履歴の読み取り
- [x] FE00: 楽天Edy
    - 残高の読み取りと表示
    - 利用履歴の読み取り
- [x] FE00: nanaco
    - 残高の読み取りと表示
    - 利用履歴の読み取り
- [x] FE00: WAON
    - 残高の読み取りと表示
    - 利用履歴の読み取り
- [x] FE00: 大学生協プリペイドカード（大学 学生証）
    - 残高の読み取りと表示
    - 利用履歴の読み取り
- [x] 8008: 八達通
    - 残高の読み取りと表示


## 使い方 / How to use
`Examples` 配下にサンプルを掲載。
### Swift Package Manager
Xcode 11: File > Swift Package > Add Package Dependency... > Enter package repository URL
```
https://github.com/treastrain/TRETJapanNFCReader
```
### Carthage
`Cartfile` に以下を記述し、`carthage update`
```
github "treastrain/TRETJapanNFCReader"
```
### CocoaPods
`Podfile` に以下を記述し、`pod install`
```
pod 'TRETJapanNFCReader'
```

### 全 NFC カード共通
1. プロジェクトの TARGET から開発している iOS Application を選び、Signing & Capabilities で Near Field Communication Tag Reading を有効にする（Near Field Communication Tag Reader Session Formats が entitlements ファイルに含まれている必要がある）。
2. Near Field Communication Tag Reader Session Formats の中に "NFC tag-specific data protocol (TAG)" が含まれていることを確認する。
3. 開発している iOS Application の Info.plist に "Privacy - NFC Scan Usage Description (NFCReaderUsageDescription)" を追加する。

### NFC-B (Type-B)
#### 運転免許証の場合
1. 運転免許証を読み取るには、開発している iOS Application の Info.plist に "ISO7816 application identifiers for NFC Tag Reader Session (com.apple.developer.nfc.readersession.iso7816.select-identifiers)" を追加する。ISO7816 application identifiers for NFC Tag Reader Session には以下を含める必要がある。
- Item 0: `A0000002310100000000000000000000`
- Item 1: `A0000002310200000000000000000000`
- Item 2: `A0000002480300000000000000000000`

2. ライブラリをインポートし、`DriversLicenseReader` を初期化した後でスキャンを開始する。
```swift
import UIKit
import TRETJapanNFCReader
class ViewController: UIViewController, DriversLicenseReaderSessionDelegate {

    var reader: DriversLicenseReader!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reader = DriversLicenseReader(self)
        self.reader.get(items: DriversLicenseCardItem.allCases, pin1: "暗証番号1", pin2: "暗証番号2")
    }

    func driversLicenseReaderSession(didRead driversLicenseCard: DriversLicenseCard) {
        // driversLicenseCard に読み取った運転免許証の情報が格納されている
    }
}
```

#### マイナンバーカードの場合
1. マイナンバーカードを読み取るには、開発している iOS Application の Info.plist に "ISO7816 application identifiers for NFC Tag Reader Session (com.apple.developer.nfc.readersession.iso7816.select-identifiers)" を追加する。ISO7816 application identifiers for NFC Tag Reader Session には以下を含める必要がある。
- Item 0: `D392F000260100000001`
- Item 1: `D3921000310001010408`
- Item 2: `D3921000310001010100`
- Item 3: `D3921000310001010401`

2. ライブラリをインポートし、`IndividualNumberReader` を初期化した後でスキャンを開始する。
```swift
import UIKit
import TRETJapanNFCReader
class ViewController: UIViewController, IndividualNumberReaderSessionDelegate {

    var reader: IndividualNumberReader!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 取得したい情報を指定
        let items: [IndividualNumberCardItem] = [.tokenInfo, .individualNumber]
        // 券面入力補助用パスワード
        let cardInfoInputSupportAppPIN = "1234"
        
        self.reader = IndividualNumberReader(delegate: self)
        self.reader.get(items: items, cardInfoInputSupportAppPIN: cardInfoInputSupportAppPIN)
    }

    func individualNumberReaderSession(didRead individualNumberCardData: IndividualNumberCardData) {
        print(individualNumberCardData)
    }

    func japanNFCReaderSession(didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }

    // パスワードの残り試行回数を取得する場合
    func lookupRemaining() {
        // 取得したい残り試行回数の種別を指定
        let pinType: IndividualNumberCardPINType = .digitalSignature
        
        self.reader.lookupRemainingPIN(pinType: pinType) { (remaining) in
            print("Remaining:", remaining)
        }
    }
}
```

### NFC-F (Type-F, FeliCa)
- FeliCa を読み取るには、開発している iOS Application の Info.plist に "ISO18092 system codes for NFC Tag Reader Session (com.apple.developer.nfc.readersession.felica.systemcodes)" を追加し、読み取る際に使用する FeliCa システムコードを記述する。ワイルドカードは使用できない。
各カードに対応する `Reader` と `Card` がある。

|カードの種類|FeliCa システムコード|`Reader`|`Card`|
|:--|:--|:--|:--|
|交通系IC|`0003`|`TransitICReader`|`TransitICCard`|
|IruCa|`80DE`|`TransitICReader`|`TransitICCard`|
|PASPY|`8592`|`TransitICReader`|`TransitICCard`|
|SAPICA|`865E`|`TransitICReader`|`TransitICCard`|
|りゅーと|`8B5D`|`RyutoReader`|`RyutoCard`|
|OKICA|`8FC1`|`OkicaReader`|`OkicaCard`|
|楽天Edy|`FE00`|`RakutenEdyReader`|`RakutenEdyCard`|
|nanaco|`FE00`|`NanacoReader`|`NanacoCard`|
|WAON|`FE00`|`WaonReader`|`WaonCard`|
|大学生協ICプリペイド|`FE00`|`UnivCoopICPrepaidReader`|`UnivCoopICPrepaidCard`|
|FCFCampus(ICU)|`FE00`|`ICUReader`|`ICUCard`|
|八達通|`8008`|`OctopusReader`|`OctopusCard`|

#### 使用例
楽天Edyの例。各`Reader`、`Card`は上記の表に対応するものに書き換える。
```swift
import UIKit
import TRETJapanNFCReader
class ViewController: UIViewController, FeliCaReaderSessionDelegate {

    var reader: RakutenEdyReader!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reader = RakutenEdyReader(viewController: self)
        self.reader.get(items: [.balance])
    }

    func feliCaReaderSession(didRead feliCaCard: FeliCaCard) {
        let rakutenEdyCard = feliCaCard as! RakutenEdyCard
        let balance = rakutenEdyCard.balance! // カード残高
    }
}
```


## L10N
- 日本語 Japanese
- English


## 関連するページ / Related
- [treastrain/ios13-felica-reader: Sample project to read FeliCa on iOS 13 and later - GitHub](https://github.com/treastrain/ios13-felica-reader)
- [iOS 13 で FeliCa (Suica) にアクセス | notes from E](https://notes.tret.jp/ios13-felica-reading/)
- [iOS 13 の Core NFC で運転免許証を読み取ろう【TRETJapanNFCReader】 - Qiita](https://qiita.com/treastrain/items/f95ee3f99c6b6111e999)


## 謝辞 / Acknowledgments
### MiFare `TRETJapanNFCReader/MIFARE`
- ISO/IEC7816
- JIS X 6320-4

### マイナンバーカード `TRETJapanNFCReader/MIFARE/IndividualNumber`
マイナンバーカードの読み取り実装においては以下に掲載されている情報を参考にしました。
- [`jpki/myna`](https://github.com/jpki/myna)
- 公的個人認証サービス 利用者クライアントソフト API 仕様書【個人認証サービス AP C 言語インターフェース編】第4.3版 地方公共団体情報システム機構

### OKICA `TRETJapanNFCReader/FeliCa/Okica/`
OKICA の情報、および OKICA カード内に保存されているゆいレールの駅名情報、各バス会社名の情報は [Twitter@resi098](https://twitter.com/resi098) 様からご提供いただきました。

### 大学生協ICプリペイド `TRETJapanNFCReader/FeliCa/UnivCoopICPrepaid`
大学生協ICプリペイドの読み取り実装においては以下に掲載されている仕様を参考にしました。
- `oboenikui/UnivFeliCa.md`
    - [大学生協FeliCaの仕様](https://gist.github.com/oboenikui/ee9fb0cb07a6690c410b872f64345120)

### 八達通 `TRETJapanNFCReader/FeliCa/Octopus`
- [Octopus · metrodroid/metrodroid Wiki](https://github.com/metrodroid/metrodroid/wiki/Octopus)

各電子マネー、電子マネーサービス等の名称は一般に各社の商標、登録商標です。
本ライブラリはサービス提供各団体および各社、電子マネーカード提供各社が公式に提供するものではありません。

The names of e-money and the services are generally trademarks and registered trademarks of each company.
This library is not officially provided by e-money card service providers and others. <br><br>

## [PASMO] Thử trích xuất thông tin từ FeliCa - Thông số kỹ thuật của FeliCa [Android][Kotlin]

### 1. Giới thiệu NFC
Công nghệ này được gọi là Giao tiếp trường gần. <br><br>

Được dịch là giao tiếp không dây tầm ngắn hoặc giao tiếp không tiếp xúc. <br><br>

FeliCa có phải là NFC không? Tôi thường thấy câu hỏi này, <br><br>

[Sony :FeliCa: Khái niệm NFC](https://www.sony.co.jp/Products/felica/NFC/) được mô tả trong Định nghĩa NFC được hiển thị trong sơ đồ sau.<br>

![image](https://github.com/user-attachments/assets/3e1fa404-af96-4897-bb89-29155987ebb1) <br>

Có các phương pháp NFC được gọi là **NFC-A, NFC-B và NFC-F** và có vẻ như chúng đang hướng tới một thứ có thể được triển khai trên bất kỳ thiết bị nào.<br><br>
FeliCa thuộc tiêu chuẩn NFC-F.<br><br>




## 2. Giới thiệu về FeliCa
  + ) Giới thiệu về cấu trúc dữ liệu FeliCa
    FeliCa được giải thích trên trang [Wikipedia](https://ja.wikipedia.org/wiki/%E8%BF%91%E8%B7%9D%E9%9B%A2%E7%84%A1%E7%B7%9A%E9%80%9A%E4%BF%A1): NFC như sau. <br><br>
    ISO/IEC 18092 <br><br>
    Đó là một tiêu chuẩn quốc tế cho giao tiếp không dây được gọi là NFC (Giao tiếp trường gần). Đây là công nghệ truyền thông không dây năng lượng thấp, có thể được sử dụng trong khoảng cách hơn 10 cm. Nó đã được tiêu chuẩn hóa vào tháng 12 năm 
    2003. NFC IP-1 (Giao thức giao diện-1).<br><br>
    Vì vậy, FeliCa là một trong những phương pháp NFC được Sony quảng bá. (Tham khảo: Sony: FeliCa, Wikipedia: FeliCa)<br><br>

   Được đồng phát triển bởi Sony (quảng bá FeliCa) và NXP Semiconductors (quảng cáo MIFARE, trước đây là Philips), đây là một sản phẩm phụ kết hợp với các công nghệ truyền thông không dây không tiếp xúc thẻ IC phổ biến như FeliCa và ISO/IEC 
    14443 (MIFARE). Tần số được sử dụng là 13,56 MHz, giống như MIFARE và các tần số khác. <br><br>

   Vì vậy, FeliCa là một trong những phương pháp NFC được Sony quảng bá. (Tham khảo: [Sony: FeliCa](https://www.sony.co.jp/Products/felica/),[Wikipedia: FeliCa](https://ja.wikipedia.org/wiki/FeliCa)) <br><br>

   Trang giải thích FeliCa của Sony liệt kê các tính năng sau: <br><br>
   Nó sử dụng dải số sóng và được thực hiện ở tốc độ 212 kbps / 424 kbps. Tính năng này là ``giao tiếp đối xứng'' không sử dụng sóng mang phụ. <br><br>
   Khi nói đến tốc độ giao tiếp, ngay cả khi đưa ra các con số, đối với tôi nó không thực sự có ý nghĩa. <br><br> 
   Nói tóm lại, nó có vẻ là một phương thức giao tiếp xử lý nhanh chóng <br><br> 
   Khi tra cứu thông tin về FeliCa, tôi nghĩ cũng nên tham khảo [FeliCa Networks](https://www.felicanetworks.co.jp/), công ty phát triển chip IC FeliCa.<br><br> 
   Felica Networks: Hướng dẫn được xuất bản trong Nguyên tắc lĩnh vực chung về thông tin kỹ thuật. <br><br> 
   
    
  + ) Giới thiệu về cấu trúc dữ liệu Suica/PASMO(Giới thiệu về cấu trúc dữ liệu FeliCa)
    Dữ liệu FeliCa có hai khu vực chính: khu vực chung (khu vực miễn phí) và khu vực riêng tư.<br><br>
    Sony: Hình ảnh sau đây được hiển thị trên trang giới thiệu [FeliCa Pocket](https://www.sony.co.jp/Products/felica/felicapocket/flow/issue/)).<br><br>
    ![image](https://github.com/user-attachments/assets/3931836a-48fb-4a28-a482-07f95071f9d5) <br><br>
    Như bạn có thể thấy từ tìm kiếm hình ảnh cho "Khu vực chung của khu vực riêng tư FeliCa", thông tin cá nhân và thông tin tài chính phải được lưu trữ trong khu vực riêng tư và các thông tin khác phải được lưu trữ trong khu vực chung.<br><br>
    Khu vực chung này được quản lý bởi Felica Networks và là khu vực mà thông tin từ nhiều dịch vụ có thể cùng tồn tại.<br><br>
    ![image](https://github.com/user-attachments/assets/9d9c2aae-8a3a-4a00-99a4-50f8620c574e)<br><br>
      + )Vùng màu cam: Được quản lý và cấu hình bởi Felica Networks
      + )Vùng màu xanh nhạt: Do nhà cung cấp dịch vụ của bạn đặt
    
   Hình ảnh như được hiển thị ở trên <br><br>
   Ngoài ra, hình trên cho thấy cấu trúc của hệ thống tệp được gọi là FeliCa. <br><br>
   Có bốn lĩnh vực:<br><br> 
       + )hệ thống (システム) <br><br>
       + )khu vực (エリア) <br><br>
       + ) dịch vụ (サービス) <br><br>
       + )khối (ブロック) <br><br>
       
   
  + ) Về quy trình liên lạc với FeliCa
  **1.(hệ thống)** <br><br>
   Một hệ thống đại diện cho một đơn vị logic của các thẻ.<br><br>
   Khi thẻ vật lý được sản xuất lần đầu tiên, chỉ có Hệ thống 0 tồn tại. <br><br>
   Khi bạn thêm một hệ thống, phần còn lại của hệ thống 0 sẽ được phân bổ.<br><br>
  **2.(mã hệ thống)>** <br><br>
    Mã hệ thống là giá trị 2 byte để xác định hệ thống.<br><br>
    Phân bổ theo hoạt động kinh doanh/mục đích sử dụng.<br><br>
    Đối với phương tiện vận chuyển như Suica/PASMO, giá trị là 00 03.<br><br>
    Tôi không thể tìm thấy bất kỳ thông số kỹ thuật nào nêu rõ điều đó...<br><br>
    Vùng dành riêng từ **FE 00** đến **AA 00** được xác định trong tiêu chuẩn **JIS X 6319-4:2010.** <br><br>
    **FE 00** là mã hệ thống biểu thị khu vực chung do Felica Networks quản lý. <br><br>

    **3.khu vực** <br><br>
    Diện tích đề cập đến số khối còn lại trong vùng bộ nhớ không khả biến có thể được sử dụng và số lượng khối được phân bổ cho các dịch vụ. <br><br>
    Thông tin khu vực bao gồm liệu khu vực con có thể được tạo hay không, số khối được phân bổ, khóa khu vực và phiên bản khóa khu vực. <br><br>

    **4.dịch vụ** <br><br>
    **Dịch vụ** là một nhóm các khối trên một hệ thống tập tin.<br><br>
    Cung cấp kiểm soát truy cập cho các khối được nhóm.<br><br>
    Để truy cập các khối do một dịch vụ quản lý, hãy xác định dịch vụ đó bằng mã dịch vụ **2 byte.** <br><br>
    Ngoài ra, bằng cách chỉ định số khối **2 byte**, bạn có thể truy cập các khối trong phạm vi do dịch vụ quản lý. <br><br>
    Số khối là số thứ tự bắt đầu từ 0 trong dịch vụ. <br><br>

    **3.Mã dịch vụ** <br><br>
    **Mã dịch vụ** là giá trị 2 byte để xác định dịch vụ.<br><br>
    10 bit trên là số dịch vụ và 6 bit dưới là thuộc tính dịch vụ. <br><br>
    ![image](https://github.com/user-attachments/assets/5593ad9f-3332-4399-b43f-b87fa217a4fb)<br><br>
    Mã dịch vụ cho bản **ghi vào/ra Suica là 09 0F**, do đó việc chuyển đổi nó thành bit sẽ trở thành **0 0 0 0 1 0 0 1 0 0 0 0 1 1 1 1** và phân loại như sau.<br><br>
    Service Code: [[0 0 0 0  1 0 0 1  0 0] [0 0 1 1 1 1]] <br><br>
    [0 0 0 0  1 0 0 1  0 0] :  Số dịch vụ <br><br>
    [0 0 1 1 1 1] : thuộc tính dịch vụ <br><br>
    Thuộc tính dịch vụ là các thuộc tính liên quan đến phương thức truy cập và xác thực. <br><br>

|  tính dịch vụ    | Cột 2     | Giá trị thuộc tính dịch vụ    |
|------------------|-----------|-------------------------------|
|  dịch vụ ngẫu nhiên   | Quyền truy cập đọc/ghi: Yêu cầu xác thực |0 0 1 0 0 0|
|           | Quyền truy cập đọc/ghi: Không cần xác thực | 0 0 1 0 0 1 |
|       | Quyền truy cập chỉ đọc: yêu cầu xác thực | 0 0 1 0 1 0|
|       |Truy cập chỉ đọc: không cần xác thực| 0 0 1 0 1 0|
| dịch vụ theo chu kỳ  |Quyền truy cập đọc/ghi: Yêu cầu xác thực| 0 0 1 1 0 0|
|   |Quyền truy cập đọc/ghi: Không cần xác thực| 0 0 1 1 0 1|
|   |Quyền truy cập chỉ đọc: yêu cầu xác thực| 0 0 1 1 1 0|
|   |Truy cập chỉ đọc: không cần xác thực| 	0 0 1 1 1 1|
| Dịch vụ phối cảnh  |Truy cập trực tiếp: yêu cầu xác thực| 0 1 0 0 0 0|
|   |Truy cập trực tiếp: không cần xác thực| 0 1 0 0 0 1|
|   |Quyền truy cập hoàn lại tiền/giảm giá: Yêu cầu xác thực| 0 1 0 0 1 0|
|   |Quyền truy cập hoàn tiền/giảm dần: Không cần xác thực| 0 1 0 0 1 1|
|   |Quyền truy cập giảm: yêu cầu xác thực| 0 1 0 1 0 0|
|   |Giảm quyền truy cập: Không cần xác thực| 0 1 0 1 0 1|
|   |Quyền truy cập chỉ đọc: yêu cầu xác thực| 0 1 0 1 1 0|
|   |Truy cập chỉ đọc: không cần xác thực| 0 1 0 1 1 1|

#### Tôi sẽ tóm tắt ba dịch vụ được liệt kê trong bảng trên.
Dịch vụ ngẫu nhiên là dịch vụ mà người dùng có thể truy cập bằng cách tự do chỉ định các khối. <br><br>
Dịch vụ tuần hoàn là dịch vụ ghi vào khối cũ nhất. Được sử dụng để ghi nhật ký, v.v. <br><br>
Dịch vụ phân tích cú pháp là dịch vụ có chức năng xử lý một phần dữ liệu khối dưới dạng giá trị số và giảm giá trị của nó. <br><br>
Mặc dù không được liệt kê trong bảng trên nhưng cũng có một thứ gọi là dịch vụ chồng chéo. <br><br>
Việc chia sẻ và quản lý nhiều khối dữ liệu bằng nhiều dịch vụ được gọi là dịch vụ chồng chéo và các dịch vụ được đề cập được gọi là dịch vụ chồng chéo.<br><br>
Để biết thêm thông tin, vui lòng tham khảo Hướng dẫn sử dụng thẻ FeliCa Trích đoạn: 3.4.3, 3.4.4, 3.4.5. <br><br>

#### khối
Một khối là một đơn vị 16 byte để ghi/đọc. <br><br>
Tất cả thông tin người dùng được lưu trữ trong khối này. <br><br>
Nó cũng lưu trữ thông tin quan trọng và thông tin quản lý hệ thống tập tin. <br><br>
Đơn vị truy cập của người dùng cũng là một khối nên để lưu trữ thông tin trên 16 byte cần phải chia thông tin đó thành nhiều khối. <br><br>
Hệ thống tập tin quản lý tất cả các khối trong vùng bộ nhớ cố định. <br><br>
Sử dụng Khu vực và Dịch vụ để truy cập các khối mà người dùng sử dụng. <br><br> 

![image](https://github.com/user-attachments/assets/79189609-c0ca-4e86-8eaf-ec09f845a874)<br><br> 

Chức năng phân chia hệ thống cho phép thông tin từ nhiều hệ thống cùng tồn tại và mỗi hệ thống có thể có nhiều khu vực và dịch vụ. <br><br> 
Tiếp theo, tôi sẽ tóm tắt các loại định danh khác nhau.<br><br> 

 + )IDm (ID sản xuất)
 + )PMm (Thông số sản xuất)

Chúng tôi sẽ tổng hợp thông tin về từng mã bằng tài liệu Mô tả mã công nghệ [FeliCa của Sony (Mô tả mã công nghệ FeliCa).](https://www.sony.co.jp/Products/felica/business/tech-support/st_code.html).<br><br> 

### Giới thiệu về IDm
IDm (ID sản xuất) là ID để nhận dạng thẻ của đối tác truyền thông.<br><br> 
Đây là giá trị 8 byte theo sau mã phản hồi của phản hồi Bỏ phiếu (được mô tả sau).<br><br> 
Hai byte trên được gọi là mã nhà sản xuất và sáu byte tiếp theo được gọi là số nhận dạng thẻ.<br><br> 

![image](https://github.com/user-attachments/assets/b66ef215-35a1-4ba9-a5b3-6db89cec1afc) <br><br> 

Nếu có nhiều hệ thống trên thẻ, IDm sẽ được đặt cho từng hệ thống riêng lẻ. Trong trường hợp này, 4 byte trên của mã nhà sản xuất cho biết số hệ thống nội bộ của thẻ.
<br><br> 

Bạn đã chỉ ra "4 byte trên". Bạn nói mã nhà sản xuất là 2 byte, nhưng 4 byte trên có nghĩa là gì? ! Đó là những gì nó cảm thấy như thế. Chúng tôi sẽ kiểm tra lại thông tin nên vui lòng đợi thông tin chính xác. (2019-10-07) <br><br> 

Nếu 1 byte thấp hơn của mã nhà sản xuất là **FE** thì loại số nhận dạng thẻ được xác định.<br><br> 

Đối với bất kỳ giá trị nào khác, Sony sẽ chỉ định số nhận dạng thẻ theo hệ thống do nhà sản xuất thẻ chỉ định.<br><br> 

Ví dụ: ID PASMO của tôi là 01 10 04 10 2C 14 1E 30, vì vậy việc phân loại như sau. <br><br> 

IDm: [[01 10] [04 10  2C 14 1E 30]] <br><br> 
[01 10] : Mã nhà sản xuất <br><br> 

[04 10  2C 14 1E 30] : Số nhận dạng thẻ <br><br> 

Vì 1 byte thấp hơn của mã nhà sản xuất không phải là FE nên đây là số nhận dạng thẻ do Sony ấn định.<br><br> 

Có quy định rõ ràng rằng tùy thuộc vào hệ thống số nhận dạng thẻ, số nhận dạng thẻ có thể không phải là giá trị duy nhất cho mỗi thẻ.<br><br> 

Bảng sau đây được giới thiệu trong tài liệu như một ví dụ về mã nhà sản xuất và hệ thống số nhận dạng thẻ cũng như cách sử dụng sản phẩm thẻ. <br><br> 


|  Mã nhà sản xuất   | Hệ thống số nhận dạng thẻ     | Ví dụ sử dụng sản phẩm thẻ    |
|------------------|-----------|-------------------------------|
|  01 FE   | Số ngẫu nhiên (được chỉ định theo ISO/IEC 18092 (NFCIP-1)) |Sản phẩm tương thích NFCIP-1|
|  02 FE   | Không có hệ thống đánh số |Thẻ loại 3 của diễn đàn NFC|
|  03 FE  | Hệ thống đánh số bao gồm mã định dạng dữ liệu do Sony quy định |FeliCa Plug|
|  XX FE không phải ở trên  | sự đặt chỗ ||
|  Khác với những điều trên  | Hệ thống số do nhà sản xuất thẻ quy định (đơn vị cấp IDm) |Thẻ tiêu chuẩn FeliCa, v.v.|

### Về PMm

PMm (Thông số sản xuất) là thông số để xác định hiệu suất của đối tác truyền thông. <br><br> 
Đây là giá trị 8 byte theo sau IDm trong phản hồi Bỏ phiếu (được mô tả sau). <br><br> 
2 byte trên được gọi là mã IC và 6 byte tiếp theo được gọi là tham số thời gian phản hồi tối đa.<br><br> 

![image](https://github.com/user-attachments/assets/da2df929-cf22-4b84-98c2-10b5185cbe9c) <br><br> 

Mã IC là mã để nhận biết loại chip IC. Byte 1 phía trên cho biết loại ROM và 1 byte phía dưới cho biết loại IC. <br><br> 
Những mã có mã IC FF FF được sử dụng trong phiên bản sửa đổi JIS X 6319-4:2005 và thông số kỹ thuật của Diễn đàn NFC. <br><br> 

Các giá trị khác được gán cho từng loại chip IC và do Sony quản lý.<br><br> 
Ví dụ: PMm của PASMO của tôi là 10 0B 4B 42 7C 7B 30 01, do đó phép chia như sau.<br><br> 

PMm: [[10 0B] [4B 42 7C 7B 30 01]] <br><br> 
[10 0B] :    <br><br>  
[4B 42 7C 7B 30 01] :      <br><br>  
   
    
      
  + ) NFC là một tiêu chuẩn giao tiếp trường gần.
### 3. bản tóm tắt


