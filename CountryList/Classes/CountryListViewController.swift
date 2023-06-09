import UIKit

final class CountryListViewController: UIViewController {
    private let viewModel: CountryListViewModeling
    
    override func viewDidLoad() {
        setupLayout()
        viewModel.getCountries()
    }
    
    init(viewModel: CountryListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension CountryListViewController: CountryListViewModelDelegate {
    func presentCountries() {
        
    }
}

private extension CountryListViewController {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
        setupViews()
    }
    
    func setupHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupViews() {
        view.backgroundColor = .white
        title = "Countries"
    }
}
