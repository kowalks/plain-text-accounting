//
//  AccountViewModel.swift
//  plain-text-accounting
//
//  Created by Guilherme Kowalczuk on 23/06/24.
//

import Foundation

@Observable
class ModelData {
    var accounts: [Account]
    var charts: [ChartType]

    init() {
        let balanceSheet = AccountViewModel.fetchAccounts()
        self.charts = balanceSheet.0
        self.accounts = balanceSheet.1
    }
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
    
    static func fetchAccounts() -> ([ChartType], [Account]) {
        let models: TreeWrapper<[AccountViewModel]> = fetch("http://127.0.0.1:5000/guilherme-kowalczuk/api/balance_sheet")
        return (models.charts, models.trees.map { $0.asAccount() })
    }
}

struct ResponseWrapper<T: Decodable>: Decodable {
    let data: T
}

struct TreeWrapper<T: Decodable>: Decodable {
    let charts: [ChartType]
    let trees: T
}

func fetch<T: Decodable>(_ url: String) -> TreeWrapper<T> {
    guard let url = URL(string: url) else {
        fatalError("String \(url) is not a valid URL.")
    }
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode(ResponseWrapper<TreeWrapper<T>>.self, from: data)
        
        if case let .balance(balanceChart) = result.data.charts[0] {
            print(balanceChart.type)
        }
        
        return result.data
    } catch {
        fatalError("Failed to fetch data from \(url): \(error.localizedDescription)")
    }
}
