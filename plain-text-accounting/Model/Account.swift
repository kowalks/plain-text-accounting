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
