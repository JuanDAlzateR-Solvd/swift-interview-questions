import Foundation

enum Question01 {
    static func run() {
        do {
            let records = try loadBankRecords()
            let summaries = calculateUserSummaries(from: records)

            for (_, summary) in summaries.sorted(by: { $0.key < $1.key }) {
                summary.printSummary()
            }
        } catch {
            print("Failed to load bank records: \(error)")
        }
    }

    struct BankRecord: Decodable {
        let recordId: String
        let userId: String
        let userName: String
        let accountNumber: String
        let type: String
        let currency: String
        let amount: Double
        let timestamp: Date
        let description: String
        let status: String
    }

    struct UserBankSummary {
        let userId: String
        let userName: String
        var recordCount: Int
        var totalAmount: Double

        func printSummary() {
            print(
                "User ID: \(userId),\t" +
                "User Name: \(userName),\t" +
                "Records: \(recordCount),\t" +
                "Total Amount: \(totalAmount)"
            )
        }
    }

    static func loadBankRecords() throws -> [BankRecord] {
        guard let url = Bundle.module.url(forResource: "BankRecords", withExtension: "json") else {
            throw NSError(
                domain: "BankRecordsError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Could not find JSON file."]
            )
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode([BankRecord].self, from: data)
    }

    static func calculateUserSummaries(from records: [BankRecord]) -> [String: UserBankSummary] {
        var summaries: [String: UserBankSummary] = [:]

        for record in records {
            if var summary = summaries[record.userId] {
                summary.recordCount += 1
                summary.totalAmount += record.amount
                summaries[record.userId] = summary
            } else {
                summaries[record.userId] = UserBankSummary(
                    userId: record.userId,
                    userName: record.userName,
                    recordCount: 1,
                    totalAmount: record.amount
                )
            }
        }

        return summaries
    }
}