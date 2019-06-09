import Foundation

class CSV2Localizables {
	
	private typealias Key = String
	private typealias LanguageId = String
	private typealias Content = String
	
	private let csvURL: URL
	private let options: Options
	
	init(csvURL: URL, options: Option...) {
		self.csvURL = csvURL
		self.options = Options(from: options)
	}

	func writeFiles(to outputURL: URL) {
		
		let translationByKey = translations(from: self.csvURL)
		let translationsByLanguage = translationByLanguage(from: translationByKey)
		
		for (languageKey, keyContent) in translationsByLanguage {
			
			let languageFolderURL = outputURL.appendingPathComponent("\(languageKey).lproj")
			guard (try? FileManager.default.createDirectory(at: languageFolderURL, withIntermediateDirectories: true)) != nil else { continue }
			
			let localizableStrings: String = keyContent.map { #""**\#($0)**" = "\#($1)";"# }.joined(separator: "\n")
			let localizableStringURL = languageFolderURL.appendingPathComponent("Localizable.strings")
			try? FileManager.default.removeItem(at: localizableStringURL)
			guard FileManager.default.createFile(atPath: localizableStringURL.path, contents: Data(localizableStrings.utf8)) else { continue }
		}

	}

	private func translations(from url: URL) -> [Key: [LanguageId: Content]] {
		
		guard let data = FileManager.default.contents(atPath: url.path) else { return [:] }
		let csv = String(decoding: data, as: UTF8.self)
		var translationsOutput: [Key: [LanguageId: Content]] = [:]

		let lines = csv.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
		let columnNames = lines.first?.split(separator: options.columnSeparator) ?? []
		let languages = Array(columnNames.dropFirst())
		let linesSkippingColumnNames = lines.dropFirst()

		for line in linesSkippingColumnNames {
			
			let lineParts = line.split(separator: options.columnSeparator)
			
			guard lineParts.count == columnNames.count else { 
				if lineParts.count > 0 {
					assertionFailure("Bad parse or one language is missing its localization.\n - Full line: \(line)\n - Line parts\(lineParts)")
				}
				continue
			} 
			
			var languagesDictionary: [LanguageId: Content] = [:]
			for (language, linePart) in zip(languages, lineParts.dropFirst()) {
				let languageId = String(language)
				languagesDictionary[languageId] = scape(text: String(linePart))
			}
			
			let key = String(lineParts[0])
			translationsOutput[key] = languagesDictionary
		}
		
		return translationsOutput
	}
	
	private func scape(text: String) -> String {
		let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
		let trimmedQuotes = trimmed.replacingOccurrences(of: "\"", with: #"\""#)
		let trimmedSeparator = trimmedQuotes.replacingOccurrences(of: String(options.columnSeparator), with: "_")
		let explicitNewlineCharacter = trimmedSeparator.replacingOccurrences(of: #"\\n"#, with: #"\n"#)
		return explicitNewlineCharacter
	}

	private func translationByLanguage(from translationByKey: [Key: [LanguageId: Content]]) -> [LanguageId: [Key: Content]] {
		var translationByLanguage: [LanguageId: [Key: Content]] = [:]
		for (key, languageAndContent) in translationByKey {
			for (languageKey, content) in languageAndContent {
				if translationByLanguage[languageKey] == nil {
					translationByLanguage[languageKey] = [:]
				}
				translationByLanguage[languageKey]?[key] = content
			}
		}
		return translationByLanguage
	}
}
extension CSV2Localizables {
	enum Option {
		case columnSeparator(Character)
		case failIfMissingLocalization(Bool)
	}
	fileprivate struct Options {
		
		var columnSeparator: Character = "~"
		var failIfMissingLocalization: Bool = true
		
		init(from optionArray: [Option]) {
			for option in optionArray {
				switch option {
				case .columnSeparator(let character):
					self.columnSeparator = character
				case .failIfMissingLocalization(let flag):
					self.failIfMissingLocalization = flag
				}
			}
		}
	}
}

//

let projectName = "99_Stocks"
let projectBaseURL = URL(fileURLWithPath: "/Users/daniel/Documents/Programming/IDE Projects/Xcode/Projects/- TestProjects/\(projectName)", isDirectory: true) 

//

let currentDirectoryURL = projectBaseURL.appendingPathComponent("Generation/Localization", isDirectory: true)
let csvURL = currentDirectoryURL.appendingPathComponent("Localizable.csv", isDirectory: false)


let csv2Localizables = CSV2Localizables(csvURL: csvURL, options: .columnSeparator(";"))
csv2Localizables.writeFiles(to: projectBaseURL.appendingPathComponent("\(projectName)/Resources"))