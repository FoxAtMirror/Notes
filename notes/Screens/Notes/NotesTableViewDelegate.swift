//
//  NotesTableViewDelegate.swift
//  notes
//
//  Created by Владислав on 02.02.2024.
//

import UIKit

protocol INotesTableViewDelegate: UITableViewDelegate {
	var didSelectHandler: ((Int) -> Void)? { get set }
	var didRemoveCellHandler: ((IndexPath) -> Void)? { get set }
}

final class NotesTableViewDelegate: NSObject {
	var didSelectHandler: ((Int) -> Void)?
	var didRemoveCellHandler: ((IndexPath) -> Void)?
}

extension NotesTableViewDelegate: INotesTableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		cell?.setSelected(false, animated: true)

		self.didSelectHandler?(indexPath.row)
	}

	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
			self?.didRemoveCellHandler?(indexPath)
		}

		deleteAction.image = UIImage(systemName: "trash")

		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
}
