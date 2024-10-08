import Foundation
import UIKit

struct HomeDetailRouterInput {
    private func currentViewController(homeDetailEntity: HomeDetailEntity) -> HomeDetailViewController {
        let view = HomeDetailViewController()
        view.homeDetailEntity = homeDetailEntity
        return view
    }

    func present(from: Viewable, homeDetailEntity: HomeDetailEntity) {
        let nav = UINavigationController(rootViewController: currentViewController(homeDetailEntity: homeDetailEntity))
        from.present(nav)
    }
}
