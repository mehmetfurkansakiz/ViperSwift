import Foundation

class HomePresenter: HomeViewPresenterInput {
    private let interactor: HomeInteractor
    private let viewInputs: HomeViewInputs
    private let networkErrorHandler: NetworkErrorHandler
    private let viewEntity: HomeViewEntity
    private let router: HomeRouterOutput

    init(interactor: HomeInteractor, viewInputs: HomeViewInputs, networkInputs: UINetworkInput, viewable: Viewable, viewEntity: HomeViewEntity) {
        self.interactor = interactor
        self.viewInputs = viewInputs
        self.networkErrorHandler = NetworkErrorHandler(viewInput: networkInputs)
        self.viewEntity = viewEntity
        self.router = HomeRouterOutput(viewController: viewable)
            
    }

    private func fetchCats() {
        interactor.fetchCats(url: "\(ProductConstants.BASE_URL)\(ServicePaths.cats.rawValue)") { response in

            switch response {
            case .success(let items):
                self.viewInputs.reloadTableView(cats: items)
            case .failure:
                print("")
            }

            self.viewInputs.indicatorView(animate: false)
        }
    }

    private func fetchCatsAsync() async {
        let response = await interactor.fetchCatsAsync()

        switch response {
        case .success(let items):
            viewInputs.reloadTableView(cats: items ?? [])
        case .failure(let error):
            networkErrorHandler.handleError(error: error)
        }
    }

    func onTapCell(model: CatEntity) {
        // TODO: Navigation with HomeRouter
        router.navigateToDetail(cat: model)
    }

    func viewDidLoad() {
        viewInputs.indicatorView(animate: true)
        viewInputs.updateTitle(title: viewEntity.title)
        Task {
            @MainActor in
            await fetchCatsAsync()
        }
    }
}
