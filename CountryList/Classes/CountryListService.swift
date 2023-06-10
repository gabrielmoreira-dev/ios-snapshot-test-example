typealias CountryListServiceCompletion = ([Country]) -> Void

protocol CountryListServicing {
    func fetchCountries(completion: CountryListServiceCompletion)
}

final class CountryListService: CountryListServicing {
    func fetchCountries(completion: CountryListServiceCompletion) {
        completion([
            Country(name: "England", capital: "London", flagImage: "eng", isKnown: true),
            Country(name: "Brazil", capital: "Brasilia", flagImage: "bra", isKnown: true),
            Country(name: "France", capital: "Paris", flagImage: "fra", isKnown: false),
            Country(name: "Japan", capital: "Tokyo", flagImage: "jpn", isKnown: false),
            Country(name: "Germany", capital: "Berlin", flagImage: "ger", isKnown: true)
        ])
    }
}
