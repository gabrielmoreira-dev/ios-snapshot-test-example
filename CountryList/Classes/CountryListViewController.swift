import UIKit

final class CountryListViewController: UIViewController {
    private let viewModel: CountryListViewModeling
    private let cellIdentifier = String(describing: UITableViewCell.self)
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
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
    }
}

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let country = viewModel.countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = "Capital: \(country.capital)"
        cell.imageView?.image = UIImage(named: country.flagImage)
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
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupViews() {
        view.backgroundColor = .white
        title = "Countries"
    }
}
