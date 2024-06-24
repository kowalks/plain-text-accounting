//
//  Account.swift
//  plain-text-accounting
//
//  Created by Guilherme Kowalczuk on 23/06/24.
//

import SwiftUI

struct AccountRow: View {
    var account: Account
    
    var body: some View {
        HStack {
            Circle()
                .fill(account.color)
                .frame(width: 7)
            
            Text(account.shortName)
            
            Spacer()
            
            Text(account.amount.formatted(
                .currency(code: account.currency)))
                .alignmentGuide(.trailing) { d in d[.trailing] }
                .padding(.trailing, 10)
            
            
        }
    }
}

#Preview {
    let modelData = ModelData()
    return Group {
        AccountRow(account: modelData.accounts[0])
        AccountRow(account: modelData.accounts[1].children![0])
    }
}
