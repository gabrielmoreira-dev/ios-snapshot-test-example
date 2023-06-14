import Foundation

protocol CountryListViewModelDelegate: AnyObject {
    func presentCountries()
}

protocol CountryListViewModeling {
    var countries: [Country] { get }
    func getCountries()
    func getImage(address: String, completion: @escaping (Data?) -> Void)
}

final class CountryListViewModel {
    private let service: CountryListServicing
    weak var delegate: CountryListViewModelDelegate?
    var countries: [Country] = []
    
    init(service: CountryListServicing) {
        self.service = service
    }
}

extension CountryListViewModel: CountryListViewModeling {
    func getCountries() {
        service.fetchCountries { [weak self] in
            guard let self = self else { return }
            self.countries = $0
            self.delegate?.presentCountries()
        }
    }
    
    func getImage(address: String, completion: @escaping (Data?) -> Void) {
        service.fetchImage(address: address) { result in
            switch result {
            case let .success(data):
                completion(data)
            case .failure:
                completion(nil)
            }
        }
    }
}
