//
//  SignUpViewController.swift
//  JackFlix_Codebase
//
//  Created by gnksbm on 6/4/24.
//

import UIKit

import SnapKit

final class SignUpViewController: UIViewController { 
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.textColor = #colorLiteral(red: 0.927328527, green: 0.3260859847, blue: 0.2540297806, alpha: 1)
        label.text = "JACKFLIX"
        return label
    }()
    
    private let stackView = {
        let signUpButton = UIButton()
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.label, for: .normal)
        signUpButton.backgroundColor = .systemBackground
        signUpButton.layer.cornerRadius = 6
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        var arrangedSubViews
        = SignUpField.allCases.map { $0.makeTextField() } + [signUpButton]
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let additionalInfoLabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.text = "추가 정보 입력"
        return label
    }()
    
    private let infoSwitch = {
        let `switch` = UISwitch()
        `switch`.onTintColor = #colorLiteral(red: 0.927328527, green: 0.3260859847, blue: 0.2540297806, alpha: 1)
        `switch`.isOn = true
        return `switch`
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
        [titleLabel, stackView, additionalInfoLabel, infoSwitch]
            .forEach {
                view.addSubview($0)
            }
        
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints { make in
            make.top.centerX.equalTo(safeArea)
        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalTo(safeArea)
            make.width.equalTo(safeArea).multipliedBy(0.8)
        }
        
        additionalInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(stackView)
            make.top.equalTo(stackView.snp.bottom).offset(20)
        }
        
        infoSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(additionalInfoLabel)
            make.trailing.equalTo(stackView)
        }
    }
}

extension SignUpViewController {
    enum SignUpField: Int, CaseIterable {
        case emailOrPhoneNumber, password, nickname, location, recommendCode
        
        private var placeholder: String {
            switch self {
            case .emailOrPhoneNumber:
                "이메일 주소 또는 전화번호"
            case .password:
                "비밀번호"
            case .nickname:
                "닉네임"
            case .location:
                "주소"
            case .recommendCode:
                "추천 코드 입력"
            }
        }
        
        func makeTextField() -> UITextField {
            let textField = UITextField()
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    .foregroundColor: UIColor.systemBackground,
                ]
            )
            textField.textAlignment = .center
            textField.borderStyle = .none
            textField.backgroundColor = .systemGray
            textField.layer.cornerRadius = 6
            textField.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
            return textField
        }
    }
}

#Preview {
    let tabBar = TabBarController()
    tabBar.selectedIndex = 1
    return tabBar
}
