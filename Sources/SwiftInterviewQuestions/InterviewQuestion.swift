import Foundation

/// Protocol that all interview questions must follow.
protocol InterviewQuestion {
    static func run()
}

/// Central registry to manage and access all questions.
struct QuestionRegistry {
    /// A dictionary mapping string names to question types.
    /// This prevents "dead code stripping" and ensures type safety.
    static let all: [String: InterviewQuestion.Type] = [
        "Question01": Question01.self,
        "Question02": Question02.self,
        "Question03": Question03.self,
        "Question04": Question04.self,
        "Question05": Question05.self,
        "Question06": Question06.self,
        "Question07": Question07.self,
        "Question08": Question08.self,
        "Question09": Question09.self,
        "Question10": Question10.self,
        "Question11": Question11.self,
        "Question12": Question12.self,
        "Question13": Question13.self,
        "Question14": Question14.self,
        "Question15": Question15.self,
        "Question16": Question16.self,
        "Question17": Question17.self,
        "Question18": Question18.self,

        "Question03v4": Question03v4.self,
        "Question04v2": Question04v2.self,
         // Add new questions here
    ]
}