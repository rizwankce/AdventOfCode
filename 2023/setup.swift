#!/usr/bin/xcrun --toolchain default swift

import Foundation

let fileManager = FileManager.default

func getLatestDay() -> Int {
    do {
        let files = try fileManager.contentsOfDirectory(atPath: "Sources")
        let dayFiles = files.filter { $0.hasPrefix("Day") }
        let numbers = dayFiles.filter { $0.contains("swift") }.compactMap {
            Int($0.dropFirst(3).dropLast(6))
        }
        return numbers.max()!
    }
    catch {
        print("Error: \(error)")
    }
    return 0
}

func createFile(directory: String, fileName: String, content fileContent: String) {
    let fileURL = URL(fileURLWithPath: directory + fileName)

    do {
        try fileContent.write(to: fileURL, atomically: true, encoding: .utf8)
        print("New file created: \(fileName)")
    }
    catch {
        print("Error creating file: \(error)")
    }
}

func createData(_ newDayNumber: String) {
    createFile(directory: "Sources/Data/", fileName: "Day" + newDayNumber + ".txt", content: "")
}

func createDay(_ newDayNumber: String) {
    let directory = "Sources/"
    let newFileName = "Day" + newDayNumber + ".swift"
    let fileContent = """
    import Algorithms

    struct Day\(newDayNumber): AdventDay {
        var data: String

        var input: [String] {
            data.lines
        }

        func part1() -> Any {
            return ""
        }

        func part2() -> Any {
            return ""
        }
    }
    """
    createFile(directory: directory, fileName: newFileName, content: fileContent)
}

func createTest(_ newDayNumber: String) {
    let directory = "Tests/"
    let newFileName = "Day" + newDayNumber + ".swift"
    let fileContent = """
    import XCTest

    @testable import AdventOfCode

    final class Day\(newDayNumber)Tests: XCTestCase {
        let testData = \"""
            \"""

        func testPart1() throws {
            let challenge = Day\(newDayNumber)(data: testData)
            XCTAssertEqual(String(describing: challenge.part1()), "")
        }

        func testPart2() throws {
            let challenge = Day\(newDayNumber)(data: testData)
            XCTAssertEqual(String(describing: challenge.part2()), "")
        }
    }
    """
    createFile(directory: directory, fileName: newFileName, content: fileContent)
}

func setup() {
    let currentDay = getLatestDay()
    let newDayNumber = (currentDay + 1 < 10 ? "0" : "") + "\(currentDay+1)"
    print("Preparing for Day \(newDayNumber)")

    createData(newDayNumber)
    createDay(newDayNumber)
    createTest(newDayNumber)
}


setup()
