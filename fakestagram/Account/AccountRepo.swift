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
    private let storage = CodableStorage<Account>(filename: "account.json")
    
    typealias accountResponse = (Account) -> Void
    
    func loadOrCreate(success: accountResponse?) {
        if let account = load() {
            success?(account)
            return
        }
        
        let newAccount = Account.initialize()
        create(newAccount) { [weak self] account in
            _ = self?.storage.save(data: account)
            success?(account)
        }
    }

    func load() -> Account? {
        return storage.load()
    }
    
    func create(_ account: Account, success: @escaping (Account) -> Void) {
        restClient.create(codable: account, success: success)
    }
}
