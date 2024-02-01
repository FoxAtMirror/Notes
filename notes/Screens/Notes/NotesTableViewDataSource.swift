//
//  NotesTableViewDataSource.swift
//  notes
//
//  Created by Владислав on 02.02.2024.
//

import UIKit

protocol INotesTableViewDataSource: UITableViewDataSource {
	var notes: [NoteModel] { get }

	func addNotes(_ notes: [NoteModel])
	func removeNote(at row: Int)
	func clearNotes()
}

final class NotesTableViewDataSource: NSObject {
	var notes: [NoteModel]

	init(notes: [NoteModel] = []) {
		self.notes = notes
	}
}

extension NotesTableViewDataSource: INotesTableViewDataSource {
	func removeNote(at row: Int) {
		self.notes.remove(at: row)
	}
	
	func addNotes(_ notes: [NoteModel]) {
		self.notes += notes
	}
	
	func clearNotes() {
		self.notes.removeAll()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.notes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.reuseIdentifier, for: indexPath) as? NotesTableViewCell 
		else { return UITableViewCell() }

		let model = self.notes[indexPath.row]

		cell.configure(with: model)

		return cell
	}
}
