import UIKit

class HomeDetailViewController: UIViewController {
    var homeDetailEntity: HomeDetailEntity?
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = homeDetailEntity?.cat?.description ?? ""
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(labelTitle)
        MakeUIConstraints()
    }
}

extension HomeDetailViewController {
    func MakeUIConstraints() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
        }

        labelTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
