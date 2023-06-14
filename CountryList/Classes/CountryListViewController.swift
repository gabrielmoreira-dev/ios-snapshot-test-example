import UIKit

final class CountryListViewController: UIViewController {
    private let viewModel: CountryListViewModeling
    private let cellIdentifier = String(describing: CountryListTableViewCell.self)
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.register(CountryListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorView: UIView = {
        let view = ErrorView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        tableView.reloadData()
        tableView.isHidden = viewModel.countries.isEmpty
        errorView.isHidden = !viewModel.countries.isEmpty
    }
}

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                as? CountryListTableViewCell else {
            return UITableViewCell()
        }
        
        let country = viewModel.countries[indexPath.row]
        cell.setup(with: CountryListTableViewCellModel(
            title: country.name,
            description: "Capital: \(country.capital)",
            isSelected: country.isKnown
        ))
        
        viewModel.getImage(address: country.flagImage) { data in
            var image = UIImage(systemName: "person.crop.circle.badge.xmark")
            if let data = data {
                image = UIImage(data: data)
            }
            cell.setupImage(image ?? UIImage())
        }
        
        return cell
    }
}

private extension CountryListViewController {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
        setupViews()
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(errorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupViews() {
        view.backgroundColor = .white
        title = "Countries"
    }
}
