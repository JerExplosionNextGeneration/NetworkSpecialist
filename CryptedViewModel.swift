//
//  EncryptedViewModel.swift
//  Encryptability
//
//  Created by Jerry Ren on 12/11/20.
//

import Foundation
import SecureDefaults

class CryptedViewModel {
    
    let cryptedDefault = SecureDefaults.shared
    
    func storingPasscode() {
        if !cryptedDefault.isKeyCreated {
            cryptedDefault.password =  "jerexplosion's passcode\(NSUUID().uuidString)"
        }
        guard let passcodeunwrapped = cryptedDefault.password else { return }
        cryptedDefault.setRawObject( "my passcode", forKey: passcodeunwrapped)
    }
                  
    func retrievalOfPasscode() {
        guard let passcodeunwrapped = cryptedDefault.password else { return }
        cryptedDefault.rawObject(forKey: passcodeunwrapped)
    }
    
}
     
