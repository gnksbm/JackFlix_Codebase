//
//  HomeViewController.swift
//  JackFlix_Codebase
//
//  Created by gnksbm on 6/4/24.
//

import UIKit

import SnapKit

final class HomeViewController: UIViewController {
    private let mainImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.image = UIImage.노량
        return imageView
    }()
    
    private let buttonStackView = {
        let stackView = UIStackView(
            arrangedSubviews: HomeButton.allCases.map { $0.makeButton() }
        )
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let risingContentsLabel = {
        let label = UILabel()
        label.text = "지금 뜨는 콘텐츠"
        label.textColor = .systemBackground
        return label
    }()
    
    private let imageStackView = {
        let imageList = [
            UIImage.더퍼스트슬램덩크,
            UIImage.밀수,
            UIImage.범죄도시3,
        ]
        let imageViewList = imageList.indices.map { index in
            let imageView = UIImageView()
            imageView.tag = index
            imageView.backgroundColor = .lightGray
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 8
            imageView.clipsToBounds = true
            imageView.image = imageList[index]
            let badgeView = imageView.overlayBadge()
            badgeView.forEach { $0.isHidden = .random() }
            return imageView
        }
        let stackView = UIStackView(
            arrangedSubviews: imageViewList
        )
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        view.backgroundColor = .label
    }
    
    private func configureLayout() {
        [mainImageView, buttonStackView, risingContentsLabel, imageStackView]
            .forEach {
                view.addSubview($0)
            }
        
        let safeArea = view.safeAreaLayoutGuide
        
        mainImageView.snp.makeConstraints { make in
            make.top.centerX.equalTo(safeArea)
            make.width.equalTo(safeArea).multipliedBy(0.9)
            make.height.equalTo(mainImageView.snp.width).multipliedBy(1.4)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView).offset(20)
            make.trailing.bottom.equalTo(mainImageView).offset(-20)
        }
        
        risingContentsLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
            make.leading.equalTo(safeArea).offset(10)
            make.height.equalTo(risingContentsLabel.font.lineHeight)
        }
        
        imageStackView.snp.makeConstraints { make in
            make.top.equalTo(risingContentsLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea).offset(20)
            make.trailing.equalTo(safeArea).offset(-20)
            make.bottom.equalTo(safeArea).offset(-10)
        }
    }
}

extension HomeViewController {
    enum HomeButton: CaseIterable {
        case play, likedList
        
        private var title: String {
            switch self {
            case .play:
                "재생"
            case .likedList:
                "내가 찜한 리스트"
            }
        }
        
        private var imageName: String {
            switch self {
            case .play:
                "play.fill"
            case .likedList:
                "plus"
            }
        }
        
        private var foregroundColor: UIColor {
            switch self {
            case .play:
                UIColor.label
            case .likedList:
                UIColor.systemBackground
            }
        }
        
        private var backgroundColor: UIColor {
            switch self {
            case .play:
                UIColor.systemBackground
            case .likedList:
                UIColor.secondaryLabel
            }
        }
        
        private var configuration: UIButton.Configuration {
            var configuration = UIButton.Configuration.filled()
            configuration.imagePlacement = .leading
            return configuration
        }
        
        func makeButton() -> UIButton {
            var configuration = configuration
            configuration.image = UIImage(systemName: imageName)
            configuration.baseForegroundColor = foregroundColor
            configuration.baseBackgroundColor = backgroundColor
            configuration.imagePadding = 15
            configuration.preferredSymbolConfigurationForImage
            = UIImage.SymbolConfiguration(pointSize: 18)
            var attributeContainer = AttributeContainer()
            attributeContainer.font = .boldSystemFont(ofSize: 14)
            configuration.attributedTitle = AttributedString(
                title,
                attributes: attributeContainer
            )
            return UIButton(configuration: configuration)
        }
    }
}

extension UIImageView {
    func overlayBadge() -> [UIImageView] {
        let leadingBadgeView = UIImageView()
        let trailingBadgeView = UIImageView()
        [leadingBadgeView, trailingBadgeView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            leadingBadgeView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 5
            ),
            leadingBadgeView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 5
            ),
            
            trailingBadgeView.topAnchor.constraint(equalTo: topAnchor),
            trailingBadgeView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
        ])
        
        leadingBadgeView.image = UIImage.singleBadge
        trailingBadgeView.image = UIImage.top10Badge
        let badgeViews = [leadingBadgeView, trailingBadgeView]
        badgeViews.forEach { $0.isHidden = Bool.random() }
        return badgeViews
    }
}

#Preview {
    TabBarController()
}
