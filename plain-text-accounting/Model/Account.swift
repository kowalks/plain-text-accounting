import Foundation
import SwiftUI

struct Account: Hashable, Identifiable {
    var id: Self { self }
    var name: String
    var shortName: String {
        name.split(separator: ":").last.map(String.init) ?? name
    }
    var amount: Decimal
    var currency: String = "BRL"
    var color: Color = .blue
    var children: [Account]? = nil
}

//func fetch() {
//    guard let url = URL(string: "http://127.0.0.1:5000/guilherme-kowalczuk/api/balance_sheet") else {
//        print("Invalid URL")
//        return
//    }
//    
//    var cancellable = URLSession.shared.dataTaskPublisher(for: url)
//        .map { $0.data }
    
    
//        .receive(on: DispatchQueue.main)
//        .sink(receiveCompletion: { completion in
//            switch completion {
//            case .finished:
//                break
//            case .failure(let error):
//                print("Failed to fetch accounts: \(error.localizedDescription)")
//            }
//        }, receiveValue: { [weak self] accounts in
//            self?.accounts = accounts
//        })
//}


let accounts_2 = [
    Account(name: "Assets", amount: 1000, children: [
        Account(name: "Caju", amount: 100),
        Account(name: "Nubank", amount: 100, children: [
            Account(name: "Savings", amount: 200),
            Account(name: "Investments", amount: 1000.50)
        ]),
    ]),
    Account(name: "Liabilities", amount: -4000, color: .orange, children: [
        Account(name: "CC", amount: -230.45),
        Account(name: "Splitwise", amount: -1098.76),
    ]),
]
