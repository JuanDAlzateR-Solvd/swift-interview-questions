enum Question13 {
    static func run() {
    
    let monetaryColumns = ["adDeliveryPennies", "paymentPennies"];
    let transactions = [
        "ff8bc1c2-8d45-11e9-bc42-526af7764f64": ["userId": 1, "adDeliveryPennies": 1000, "transactionTimestamp": 1500000001],
        "ff8bc2e4-8d45-11e9-bc42-526af7764f64": ["userId": 1, "adDeliveryPennies": 1000, "transactionTimestamp": 1500000002],
        "ff8bc4ec-8d45-11e9-bc42-526af7764f64": ["userId": 1, "paymentPennies": 500, "transactionTimestamp": 1500000003],
        "fv24z4ec-8d45-11e9-bc42-526af7764f64": ["userId": 1, "adDeliveryPennies": 1000, "paymentPennies": 500, "transactionTimestamp": 1500000004]        
        ]

        let result = generateBillingStatus(from: transactions, columns: monetaryColumns)
        printBillings(billings: result)
    }

    static func generateBillingStatus(from array: [String: [String: Int]], columns: [String]) -> [Int: BillingStatus] {
        var billings: [Int: BillingStatus] = [:]
        for transaction in array {
            guard let userId = transaction.value["userId"] as? Int else {
                continue
            }
            let billingStatus = billings[userId, default: BillingStatus()]
            for column in columns {
                if let pennies = transaction.value[column] as? Int {
                    if column == "adDeliveryPennies" {
                        billingStatus.addDelivery(pennies: pennies)
                    } else if column == "paymentPennies" {
                        billingStatus.addPayment(pennies: pennies)
                    }
                }
            }
            billings[userId] = billingStatus
       
        }
        return billings
    }

    static func printBillings(billings:[Int: BillingStatus]) {
        for (userId, billingStatus) in billings {
            print("User ID: \(userId), Ad delivery pennies: \(billingStatus.adDeliveryPennies), Payment pennies: \(billingStatus.paymentPennies)")           
        }
    }

    class BillingStatus {
        var adDeliveryPennies: Int = 0
        var paymentPennies: Int = 0
        init() {          
        }
        func addDelivery(pennies: Int) {
            adDeliveryPennies += pennies
        }
        func addPayment(pennies: Int) {
            paymentPennies += pennies
        }
    }
    
}
