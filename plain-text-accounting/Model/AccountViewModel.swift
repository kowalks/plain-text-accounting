//
//  AccountViewModel.swift
//  plain-text-accounting
//
//  Created by Guilherme Kowalczuk on 23/06/24.
//

import Foundation

@Observable
class ModelData {
    var accounts: [Account] = AccountViewModel.fetchAccounts()
}

class BalanceModel: Codable {
    var BRL: Decimal? = 0.5
}

class AccountViewModel: Codable {
    var account: String
    var balance: BalanceModel?
    var balance_children: BalanceModel
    var children: [AccountViewModel]?
    var has_txns: Bool
    
    private func asAccount() -> Account {
        let mappedChildren: [Account]? = self.children?.map { $0.asAccount() }
        let children: [Account]? = (mappedChildren?.isEmpty ?? true) ? nil : mappedChildren
        return Account(name: account, amount: balance?.BRL ?? 0, currency: "BRL", children: children)
    }
    
    static func fetchAccounts() -> [Account] {
        let models: [AccountViewModel] = fetch("http://127.0.0.1:5000/guilherme-kowalczuk/api/balance_sheet")
        return models.map { $0.asAccount() }
    }
}

struct ResponseWrapper<T: Decodable>: Decodable {
    let data: TreeWrapper<T>
}

struct TreeWrapper<T: Decodable>: Decodable {
    let trees: T
}

func fetch<T: Decodable>(_ url: String) -> T {
    guard let url = URL(string: url) else {
        fatalError("String \(url) is not a valid URL.")
    }
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode(ResponseWrapper<T>.self, from: data)
        return result.data.trees
    } catch {
        fatalError("Failed to fetch data from \(url): \(error.localizedDescription)")
    }
}
