# DatacheckerNFCPod

[![CI Status](https://img.shields.io/travis/omkardatachecker/DatacheckerNFCPod.svg?style=flat)](https://travis-ci.org/omkardatachecker/DatacheckerNFCPod)
[![Version](https://img.shields.io/cocoapods/v/DatacheckerNFCPod.svg?style=flat)](https://cocoapods.org/pods/DatacheckerNFCPod)
[![License](https://img.shields.io/cocoapods/l/DatacheckerNFCPod.svg?style=flat)](https://cocoapods.org/pods/DatacheckerNFCPod)
[![Platform](https://img.shields.io/cocoapods/p/DatacheckerNFCPod.svg?style=flat)](https://cocoapods.org/pods/DatacheckerNFCPod)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

    1. iOS(15.0 and above)
    2. XCode 12 and above
     

## Installation

DCNFCFramework is available through [GitHub](https://github.com/). To install
it, simply add the following line to your Podfile:

1. Add Source repo to Framework
```ruby
source 'https://github.com/datacheckerbv/DCNFCFramework_build_public.git'
```

2. Add Framework to the project.
    1. Select Target
    2. Add above added package to the app/target.



## Setup
Before buiding application, please perform following steps.

    1. Following Key values to the Info.plist file.
    ```xml
        <key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
    <array>
        <string>A0000002471001</string>
        <string>A0000002472001</string>
        <string>00000000000000</string>
    </array>
        <key>com.apple.developer.nfc.readersession.formats</key>
        <array>
        <string>TAG</string>
    </array>  
    <key>NFCReaderUsageDescription</key>
    <string>Please ask for NFC Tag reading permissions here.</string>
    ```
    
## Usage
You need to import following frameworks in your class.

```swift
import DatacheckerNFCPod
import QKMRZScanner
```

Work flow of this pod is as follows

1. Read MRZ of the Document first: 
    To read MRZ, this pod provides a separate interface/UIViewcontroller called 'MRZScanViewController'.  Please use Following code snippet to call the 'MRZScanViewController' over current ViewController. (Your view controller should conform to 'QKMRZScannerViewDataCheckerDelegate' in order to receive scan result.)
    ```swift
        private func loadMRZScanViewController() {
        let controller = MRZScanViewController()
        controller.view.backgroundColor = .green
        controller.modalPresentationStyle = .fullScreen
        controller.scanCompleteDelegate = self
        show(controller, sender: self)
    }
    ```
 

2. Receive MRZ Scannin Result in the Delegate method:
    Once the scan is complete, you will receive scanning result in the 'QKMRZScannerViewDataCheckerDelegate' method. Please refer the code snippet below.(Make sure your view controller is conforming to 'QKMRZScannerViewDataCheckerDelegate' in order to receive scan result.). Store the result in a reference variable of type 'DatacheckerNFCPod.ScanMRZResult'. 
    ```swift
        @available(iOS 15, *)
        extension ViewController: QKMRZScannerViewDataCheckerDelegate{
            func didMRZScanComplete(scanResult: DatacheckerNFCPod.ScanMRZResult) {
                self.scanResult = scanResult
            }
        }
    ```
    
3. Pass this Result to the Document Scan Utility Class:
    To Scan the NFC Enabled passport, you will need above scanned result. In this pod, there is a helper class which helps to scan the NDC passport and also returns the result in the calling class using scanned MRZ result. Please use following snippet to create instace variable of the helper class.
    
    ```swift
        var passportHelper: DocumentScanHelper!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            self.passportHelper = DocumentScanHelper(nfcScanDelegate: self)
        }
    ```
    
    Here nfcScanDelegate is of type DocumentNFCScanDelegate. Inorder to receive the NFC scan result your class/viewcontroller should
    conform to this protocol(DocumentNFCScanDelegate).
    
    Following snippet will setup and start NFC Reading.
    
    ```swift
    
        private func startPPScan() {
            if scanResult != nil {
                passportHelper.startDocumentScan(mrzScanResult: self.scanResult)
            } else {
                print("Scan Result is empty")
            }
        }
    ```
    
    Here 'scanResult' is the result received from scanning the MRZ.

    


4. Receive the Scanning result in the Document scanning delegate method: 
    Once the NFC Document scanned successfully, the helper class will return the scanned result in the delegate methods of 'DocumentNFCScanDelegate'. Please refer the following Code snippet to receive the NFC Scanned Data.
    
    ```swift
        @available(iOS 15, *)
        extension ViewController: DocumentNFCScanDelegate {
            func didNFCDocumentScanComplete(passportModel: DatacheckerNFCPod.NFCPassportModel) {
                print("Document Scan Successful")
                print("Document Number is: \(passportModel.documentNumber)")
            }
    
            func didScanErrorOccured() {
                print("Error Occured")
            }
        }
    
    ```

## Author

1. omkardatachecker, omkar@datachecker.nl
2. https://github.com/AndyQ/NFCPassportReader.git
3. https://github.com/Mattijah/QKMRZScanner.git

## License

DatacheckerNFCPod is available under the MIT license. See the LICENSE file for more info.
