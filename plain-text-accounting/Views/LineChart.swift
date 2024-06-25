//
//  Chart.swift
//  plain-text-accounting
//
//  Created by Guilherme Kowalczuk on 25/06/24.
//

import SwiftUI
import Charts

struct LineChart: View {
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        Chart {
            
        }
    }
}

#Preview {
    LineChart()
        .environment(ModelData())
}
