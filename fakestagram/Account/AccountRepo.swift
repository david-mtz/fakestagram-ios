//
//  AccountRepo.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class AccountRepo {
    static let shared = AccountRepo()
    let restClient = RestClient<Account>(client: Client(), path: "/api/accounts")
    
    typealias accountResponse = (Account) -> Void
    
    func loadOrCreate(success: accountResponse?) {
        if let account = load() {
            success?(account)
            return
        }
        let newAccount = Account.initialize()
        create(newAccount) { account in
            AccountStorage.shared.item = account
            AccountStorage.shared.save()
            AccountUserDefault.saveInStorage(account: account)
            success?(account)
        }
    }

    func load() -> Account? {
        
        if let account = AccountUserDefault.loadFromStorage() {
            AccountStorage.shared.item = account
            AccountStorage.shared.save()
            return account
        }
        
        return AccountStorage.shared.item
        
    }
    
    func create(_ account: Account, success: @escaping (Account) -> Void) {
        restClient.create(codable: account, success: success)
    }
}
