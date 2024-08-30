import SnapKit
import UIKit

final class HomeViewController: UIViewController {
    private let labelTitle: UILabel = .init()
    private let homeTableViewController: UITableView = .init()
    private let indicator: UIActivityIndicatorView = .init()
    
    private var itemCats: [CatEntity] = []

    var presenter: HomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(labelTitle)
        view.addSubview(homeTableViewController)
        view.addSubview(indicator)
        makeUIConstraints()
        presenter?.viewDidLoad()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemCats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cats \(itemCats[indexPath.row].description)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onTapCell(model: itemCats[indexPath.row])
    }
}

extension HomeViewController: HomeViewInputs {
    func updateTitle(title: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationItem.title = title
        }
    }
    
    func reloadTableView(cats: [CatEntity]) {
        
        self.itemCats = cats
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.homeTableViewController.reloadData()
        }
    }
    
    func configure() {}

    func reloadTableView() {}

    func setupTableViewCell() {}

    func indicatorView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in

            guard let self = self else { return }
            animate ? self.indicator.startAnimating() : self.indicator.stopAnimating()
            self.indicator.isHidden = !animate
        }
    }

    func sortByTitle() {}
}

// MARK: UI Draw

extension HomeViewController {
    func makeUIConstraints() {
        labelTitle.text = "Home View Controller"
        labelTitle.textColor = .red
        labelTitle.textAlignment = .center
        indicator.isHidden = false
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }

        labelTitle.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }

        homeTableViewController.snp.makeConstraints { make in
            make.top.equalTo(labelTitle).offset(20)
            make.horizontalEdges.equalTo(self.view).offset(20)
            make.bottom.equalToSuperview()
        }

        homeTableViewController.dataSource = self
        homeTableViewController.delegate = self
    }
}

extension HomeViewController: UINetworkInput {
    func presentAlert(controller: UIAlertController) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(controller, animated: true)
        }
    }
}

extension HomeViewController: Viewable {}
