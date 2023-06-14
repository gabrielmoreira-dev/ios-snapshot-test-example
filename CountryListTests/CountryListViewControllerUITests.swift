@testable import CountryList
import UIKit

final class CountryListViewControllerUITests: SnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testViewController_WhenProvidedACountryList_ShouldDisplayTheCountryList() {
        let countries = [
            Country(name: "England", capital: "London", flagImage: "eng", isKnown: true),
            Country(name: "Brazil", capital: "Brasilia", flagImage: "bra", isKnown: true),
            Country(name: "France", capital: "Paris", flagImage: "fra", isKnown: false),
            Country(name: "Japan", capital: "Tokyo", flagImage: "jpn", isKnown: false),
            Country(name: "Germany", capital: "Berlin", flagImage: "ger", isKnown: true)
        ]
        let viewModel = CountryListViewModelMock(countries: countries)
        let sut = CountryListViewController(viewModel: viewModel)
        
        sut.presentCountries()
        
        verifyViewController(sut)
    }
    
    func testViewController_WhenThereIsNoCountry_ShouldDisplayErrorView() {
        let countries = [Country]()
        let viewModel = CountryListViewModelMock(countries: countries)
        let sut = CountryListViewController(viewModel: viewModel)
        
        sut.presentCountries()
        
        verifyViewController(sut)
    }
}

final class CountryListViewModelMock: CountryListViewModeling {
    private(set) var countries: [Country]
    
    func getCountries() {}
    
    init(countries: [Country] = []) {
        self.countries = countries
    }
}
