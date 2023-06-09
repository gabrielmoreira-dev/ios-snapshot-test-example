typealias CountryListServiceCompletion = ([Country]) -> Void

protocol CountryListServicing {
    func fetchCountries(completion: CountryListServiceCompletion)
}

final class CountryListService: CountryListServicing {
    func fetchCountries(completion: CountryListServiceCompletion) {
        completion([
            Country(name: "EUA", capital: "Washington", flagImage: ""),
            Country(name: "Brazil", capital: "Brasilia", flagImage: ""),
            Country(name: "France", capital: "Paris", flagImage: ""),
            Country(name: "Japan", capital: "Tokyo", flagImage: ""),
            Country(name: "Germany", capital: "Berlin", flagImage: "")
        ])
    }
}
