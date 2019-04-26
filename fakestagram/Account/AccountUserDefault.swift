//
//  AccountDefaultStorage.swift
//  fakestagram
//
//  Created by David on 4/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class AccountUserDefault {
        
    static func loadFromStorage() -> Account? {
        
        if let uuid = Secrets.uuid.value, let name = Secrets.nameUser.value {
            return Account(
                id: uuid,
                name: name,
                deviceNumber: UIDevice.identifier,
                deviceModel: UIDevice.modelName
            )
        }
        
        return nil
    }
    
    static func saveInStorage(account: Account) {
        
        guard let id = account.id, Secrets.uuid.set(value: id), Secrets.nameUser.set(value: account.name) else {
            print("I didn't save account in storage")
            return
        }
        
    }
    

    
}
