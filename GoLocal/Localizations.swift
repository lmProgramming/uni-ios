import Foundation

var trans: [String: [String: String]] = [
    "pl": ["about": "Opis", "select-event": "Wybierz wydarzenie", "events": "Wydarzenia", "sign": "Sign in"],
    "en": ["about": "About", "select-event": "Select Event", "events": "Events", "sign": "Zaloguj sie"]
]

let langCode = "en"

extension String {
    func localize(languageCode: String? = nil) -> String {
        let currentLangCode = languageCode ?? langCode
        guard let translation = trans[currentLangCode]?[self] else {
            print("Missing translation for key: \(self) in language: \(currentLangCode)")
            return self
        }
        return translation
    }
}
