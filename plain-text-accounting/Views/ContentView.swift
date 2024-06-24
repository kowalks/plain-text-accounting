import SwiftUI

struct ContentView: View {
    var body: some View {
        AccountList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
