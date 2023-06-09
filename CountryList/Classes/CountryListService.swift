typealias CountryListServiceCompletion = ([Country]) -> Void

protocol CountryListServicing {
    func fetchCountries(completion: CountryListServiceCompletion)
}

final class CountryListService: CountryListServicing {
    func fetchCountries(completion: CountryListServiceCompletion) {
        completion([
            Country(name: "England", capital: "London", flagImage: "eng"),
            Country(name: "Brazil", capital: "Brasilia", flagImage: "bra"),
            Country(name: "France", capital: "Paris", flagImage: "fra"),
            Country(name: "Japan", capital: "Tokyo", flagImage: "jpn"),
            Country(name: "Germany", capital: "Berlin", flagImage: "ger")
        ])
    }
}
