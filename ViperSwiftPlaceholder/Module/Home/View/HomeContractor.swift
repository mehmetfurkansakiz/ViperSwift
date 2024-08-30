import Foundation

protocol HomeInteractorOutputs {
    func onSuccessSearch()
    func onErrorSearch()
}

protocol HomeViewInputs {
    func configure()
    func reloadTableView(cats: [CatEntity])
    func setupTableViewCell()
    func indicatorView(animate: Bool)
    func sortByTitle()
    func updateTitle(title: String)
}

protocol HomeViewPresenterInput {
    func viewDidLoad()
    func onTapCell(model: CatEntity)
}
