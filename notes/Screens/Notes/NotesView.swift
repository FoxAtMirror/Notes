//
//  NotesView.swift
//  notes
//
//  Created by Владислав on 02.02.2024.
//

import UIKit

protocol INotesView: UIView {
	func setTableView(dataSource: INotesTableViewDataSource, delegate: INotesTableViewDelegate)
	func viewDidLoad()
	func reloadData()
	func deleteRow(at indexPath: IndexPath)
}

final class NotesView: UIView {
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .insetGrouped)
		tableView.backgroundColor = .systemBackground
		tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.reuseIdentifier)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
}

extension NotesView: INotesView {
	func deleteRow(at indexPath: IndexPath) {
		self.tableView.deleteRows(at: [indexPath], with: .automatic)
	}
	
	func reloadData() {
		self.tableView.reloadData()
	}
	
	func setTableView(dataSource: INotesTableViewDataSource, delegate: INotesTableViewDelegate) {
		self.tableView.dataSource = dataSource
		self.tableView.delegate = delegate
	}
	
	func viewDidLoad() {
		self.configureUI()
		self.configureTableView()
	}
}

private extension NotesView {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}

	func configureTableView() {
		self.addSubview(self.tableView)
		NSLayoutConstraint.activate([
			self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
			self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
	}
}
