import Foundation

typealias CountryListServiceCompletion = ([Country]) -> Void

protocol CountryListServicing {
    func fetchCountries(completion: CountryListServiceCompletion)
    func fetchImage(address: String, completion: @escaping DownloadImageCompletion)
}

final class CountryListService: CountryListServicing {
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchCountries(completion: CountryListServiceCompletion) {
        completion([
            Country(name: "England", capital: "London", flagImage: "https://cdn.britannica.com/44/344-004-494CC2E8/Flag-England.jpg", isKnown: true),
            Country(name: "Brazil", capital: "Brasilia", flagImage: "https://upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/640px-Flag_of_Brazil.svg.png", isKnown: true),
            Country(name: "France", capital: "Paris", flagImage: "https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/1200px-Flag_of_France.svg.png", isKnown: false),
            Country(name: "Japan", capital: "Tokyo", flagImage: "https://e0.pxfuel.com/wallpapers/911/753/desktop-wallpaper-japan-flag-japanese-flag-flag-of-japan-japan.jpg", isKnown: false),
            Country(name: "Germany", capital: "Berlin", flagImage: "https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/255px-Flag_of_Germany.svg.png", isKnown: true)
        ])
    }
    
    func fetchImage(address: String, completion: @escaping DownloadImageCompletion) {
        networkManager.downloadImage(address: address) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
