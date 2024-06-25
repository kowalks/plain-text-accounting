import Foundation

protocol ChartModel: Decodable {
    var label: String { get }
    var type: String { get }
}

struct DataPointModel: Decodable {
    var balance: BalanceModel
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case balance
        case date
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        
        self.date = date
        self.balance = try container.decode(BalanceModel.self, forKey: .balance)
    }
}

struct BalancesChartModel: ChartModel {
    var data: [DataPointModel]
    var label: String
    var type: String
}

struct HierarchyChartModel: ChartModel {
    var data: AccountViewModel
    var label: String
    var type: String
}

enum ChartType: Decodable, ChartModel {
    case balance(BalancesChartModel)
    case hierarchy(HierarchyChartModel)

    var label: String {
        switch self {
        case .balance(let model as ChartModel), .hierarchy(let model as ChartModel):
            return model.label
        }
    }
    
    var type: String {
        switch self {
        case .balance(let model as ChartModel), .hierarchy(let model as ChartModel):
            return model.type
        }
    }

    // Custom decoding logic
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "balances":
            let balanceChart = try BalancesChartModel(from: decoder)
            self = .balance(balanceChart)
        case "hierarchy":
            let hierarchyChart = try HierarchyChartModel(from: decoder)
            self = .hierarchy(hierarchyChart)
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid chart type")
        }
    }

    private enum CodingKeys: String, CodingKey {
        case type
    }
}
