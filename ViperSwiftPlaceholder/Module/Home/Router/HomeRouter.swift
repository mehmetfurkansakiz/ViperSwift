import Foundation

/// input: core operations like open etc.

struct HomeRouterInput {
    func currentViewController(viewEntity: HomeViewEntity?) -> HomeViewController {
        let homeViewController = HomeViewController()

        homeViewController.presenter = HomePresenter(
            interactor: HomeInteractor(
                networkManager: AlamofireNetworkManager.shared),
            viewInputs: homeViewController,
            networkInputs: homeViewController,
            viewable: homeViewController,
            viewEntity: viewEntity ?? HomeViewEntity(title: "Home")
        )
        
        return homeViewController
    }
    
    // From arg: /// from: ViewController,
    func start(viewEntity: HomeViewEntity?) -> HomeViewController {
        currentViewController(viewEntity: viewEntity)
    }
}

/// output: external operation.

struct HomeRouterOutput {
    let viewController: Viewable
    func navigateToDetail(cat: CatEntity) {
        let detailEntity = HomeDetailEntity(cat: cat)
        HomeDetailRouterInput().present(from: viewController, homeDetailEntity: detailEntity)
    }
}
