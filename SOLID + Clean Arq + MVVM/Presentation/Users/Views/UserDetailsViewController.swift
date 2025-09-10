//
//  UserDetailsViewController.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import UIKit

class UserDetailsViewController: UIViewController {
    private let viewModel: UserDetailsViewModel

    private let nameLabel = UILabel()
    private let emailLabel = UILabel()

    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayUserDetails()
    }

    private func displayUserDetails() {
        nameLabel.text = viewModel.user.name
        emailLabel.text = viewModel.user.email
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "User Details"

        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        emailLabel.font = .systemFont(ofSize: 18, weight: .regular)
        emailLabel.textColor = .secondaryLabel

        let stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
