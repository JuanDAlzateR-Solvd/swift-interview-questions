# Swift Interview Questions

A growing collection of Swift solutions to technical interview-style problems and coding challenges.

Each question is self-contained, runnable from the command line, and implemented using idiomatic Swift 6.

---

## Requirements

- Swift 6.3 or later (`swift-tools-version: 6.3`)
- Xcode 16.3+ **or** the Swift toolchain installed separately

---

## Getting Started

```bash
git clone <repo-url>
cd swift-interview-questions
swift build
```

---

## Running a Question

```bash
swift run SwiftInterviewQuestions <QuestionName>
```

**Examples:**

```bash
swift run SwiftInterviewQuestions Question01
swift run SwiftInterviewQuestions Question04
swift run SwiftInterviewQuestions Question04v2   # alternative implementation
```

To see all registered question names:

```bash
swift run SwiftInterviewQuestions --help
```

---

## Running the Tests

```bash
swift test
```

Unit tests currently cover Questions 03, 04, 08, and 10.

---

## Questions Index

| # | Topic | Tests |
|---|-------|-------|
| 01 | Bank record processing — parse JSON, aggregate per-user summaries | |
| 02 | Matrix rectangle detection — find rectangles of `0`s in a binary matrix and return their coordinates | |
| 03 | Decode a run-length encoded string (e.g. `"2[b3[cd]]"` → `"bcdcdbcdcd"`) | ✓ |
| 04 | Palindrome and string reversal checks | ✓ |
| 05 | Nested dictionary aggregation — flatten and summarise multi-level analytics data | |
| 06 | Coin/menu optimisation — find cheapest item and maximum purchasable quantity | |
| 07 | FizzBuzz | |
| 08 | Letter Counting | ✓ |
| 09 | Anagram detection | |
| 10 | Balanced bracket validation and content extraction | ✓ |
| 11 | Dictionary inversion — group keys by value | |
| 12 | Generate all unique pairs from an array | |
| 13 | Monetary transaction aggregation — sum columns across a transaction map | |
| 14 | FizzBuzz variant (different range) | |
| 15 | JSON parsing — model and query a channel/video data structure | |
| 16 | Run-length string encoding (e.g. `"aaaabb"` → `"4a2b"`) | |
| 17 | Family tree traversal | |
| 18 | Game simulation — turn-based state machine | |

---

## Project Structure

```
.
├── Package.swift
├── Sources/
│   └── SwiftInterviewQuestions/
│       ├── InterviewQuestion.swift      # Protocol + QuestionRegistry
│       ├── SwiftInterviewQuestions.swift # CLI entry point (ArgumentParser)
│       ├── Question02/                  # Q02 with helper files
│       ├── Questions01To05/
│       ├── Questions06To10/
│       ├── Questions11To15/
│       ├── Questions16To18/
│       ├── Versions/                    # Alternative implementations
│       └── Resources/                   # JSON fixtures used at runtime
└── Tests/
    └── SwiftInterviewQuestionsTests/
```

### Adding a New Question

1. Create `ExampleNN.swift` in the appropriate `QuestionsXXToYY/` folder.
2. Define an `enum QuestionNN: InterviewQuestion` with a `static func run()` method.
3. Register it in `QuestionRegistry.all` inside `InterviewQuestion.swift`.
4. Run it with `swift run SwiftInterviewQuestions QuestionNN`.
