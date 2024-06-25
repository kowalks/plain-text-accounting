import SwiftUI
import Charts

struct AccountHeading: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
            Text("Account")
                .font(.headline)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct AccountList: View {
    @Environment(ModelData.self) var modelData

    var body: some View {
        
        NavigationView {
            List(modelData.accounts, children: \.children) { account in
                NavigationLink {
                    AccountDetail(account: account)
                } label: {
                    AccountRow(account: account)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Accounts")
        }
        
//        if case let .balance(balance) = modelData.charts[0] {
//            Chart {
//                ForEach(balance.data, id:\.date) { item in
//                    LineMark(
//                        x: .value("Date", item.date),
//                        y: .value("Profit A", item.balance.BRL ?? 0),
//                        series: .value("Company", "A")
//                    )
//                    .foregroundStyle(.blue)
//                }
//            }
//        }
    }
}

#Preview {
    AccountList()
        .environment(ModelData())
}
