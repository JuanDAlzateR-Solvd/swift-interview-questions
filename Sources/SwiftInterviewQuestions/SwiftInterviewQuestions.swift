// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser
import Foundation

@main
struct Interview: ParsableCommand {
    @Argument(help: "The name of the question to run (e.g., Question04v2)")
    var questionName: String

    func run() throws {
        // Find the question in the registry
        guard let questionType = QuestionRegistry.all[questionName] else {
            print("\n❌ Error: Question '\(questionName)' is not registered.")
            print("Available questions: \(QuestionRegistry.all.keys.sorted().joined(separator: ", "))\n")
            throw ExitCode.failure
        }

        let separator = " "+String(repeating: "=", count: 20)+" "

        print(" ")
        print(separator + "🚀 Executing: \(questionName)" + separator + "\n")
        questionType.run()
        print("\n" + separator +  "\(questionName) ✅ Done." + separator + "\n")
    }
}