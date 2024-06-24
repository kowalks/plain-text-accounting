import SwiftUI

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
    }
}

#Preview {
    AccountList()
        .environment(ModelData())
}
