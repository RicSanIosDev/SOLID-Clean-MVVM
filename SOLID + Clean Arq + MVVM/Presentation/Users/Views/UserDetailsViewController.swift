//
//  UserDetailsViewController.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import UIKit

class UserDetailsViewController: UIViewController {
    private let viewModel: UserDetailsViewModel

    private lazy var ticketView: TicketView = {
        let view = TicketView()
        view.backgroundColor = .clear
        view.bcolor = .systemGray
        view.dashColor = .black
        view.createMask = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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

        ticketView.addSubview(stackView)
        view.addSubview(ticketView)

        NSLayoutConstraint
            .activate(
                [
                    stackView.centerXAnchor
                        .constraint(
                            equalTo: ticketView.centerXAnchor
                        ),
                    stackView.topAnchor
                        .constraint(
                            equalTo: ticketView.topAnchor,
                            constant: 32
                        ),
                    ticketView.bottomAnchor
                        .constraint(
                            equalTo: stackView.bottomAnchor,
                            constant: 32
                        ),
                    ticketView.leadingAnchor
                        .constraint(
                            equalTo: view.leadingAnchor,
                            constant: 16
                        ),
                    view.trailingAnchor
                        .constraint(
                            equalTo: ticketView.trailingAnchor,
                            constant: 16
                        ),
                    ticketView.centerYAnchor
                        .constraint(
                            equalTo: view.centerYAnchor
                        ),
                ]
            )
    }
}
