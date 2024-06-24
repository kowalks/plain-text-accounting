import SwiftUI

struct AccountDetail: View {
    @Environment(ModelData.self) var modelData
    
    var account: Account
    
    var body: some View {
        Text(account.name)
    }
}

#Preview {
    let modelData = ModelData()
    return AccountDetail(account: modelData.accounts[0])
        .environment(ModelData())
}
