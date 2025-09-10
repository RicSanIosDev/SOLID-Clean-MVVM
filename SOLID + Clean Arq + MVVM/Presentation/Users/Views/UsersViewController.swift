//
//  UsersViewController.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

// En ViewController.swift

import UIKit

// 1. Cambiamos la superclase a UIViewController
class UsersViewController: UIViewController {

    // --- PROPIEDADES ---
    private let viewModel: UsersViewModel
    private var users: [User] = []

    // 2. Creamos la UITableView como una propiedad privada

    private let text: UILabel = {
        let text = UILabel()
        // ¡Importante para Auto Layout!
        text.translatesAutoresizingMaskIntoConstraints = false
        // te la celda aquí
        text.text = "HOLA"
        return text
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        // ¡Importante para Auto Layout!
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // Registramos la celda aquí
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        return tableView
    }()

    // --- INIT ---
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // --- VIEW LIFECYCLE ---
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuraciones que ya teníamos
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground // Fondo blanco para toda la vista

        // 3. Añadimos la tabla como subvista y configuramos sus constraints
        view.addSubview(text)
        view.addSubview(tableView)
        setupTableViewConstraints()

        // 4. Nos asignamos como dataSource y delegate
        tableView.dataSource = self
        tableView.delegate = self

        // Vinculamos el ViewModel
        bindViewModel()
        viewModel.viewDidLoad()
    }

    // --- BINDING ---
    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            DispatchQueue.main.async { // Siempre en el hilo principal
                switch state {
                case .loading:
                    // Manejar estado de carga
                    break
                case .loaded(let users):
                    self?.users = users
                    self?.tableView.reloadData()
                case .error(let message):
                    // Manejar error
                    print(message)
                }
            }
        }
    }

    // --- LAYOUT ---
    private func setupTableViewConstraints() {
        // 5. ¡LA CLAVE ESTÁ AQUÍ! Forzamos la tabla a ocupar toda la vista.
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: view.topAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// 6. Extendemos la clase para conformar los protocolos de UITableView
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = users[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = user.name
        content.secondaryText = user.email
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        viewModel.didSelectUser(user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
