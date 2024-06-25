import SwiftUI

struct AccountDetail: View {
    @Environment(ModelData.self) var modelData
    
    var account: Account
    
    var body: some View {
        Text(account.name)
            .font(.title)
        
        VStack(alignment: .leading) {
            Text("Amount: \(account.amount)")
                .font(.headline)
            
            Text("Color: \(account.color.description)")
                .font(.subheadline)
        }
    }
}

#Preview {
    let modelData = ModelData()
    return AccountDetail(account: modelData.accounts[0])
        .environment(ModelData())
}
