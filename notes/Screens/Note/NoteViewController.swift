//
//  NoteViewController.swift
//  notes
//
//  Created by Владислав on 02.02.2024.
//

import UIKit

final class NoteViewController: UIViewController {
	private let noteDataBaseManager: INoteDataBaseManager

	private let rootView: INoteView

	private var noteId: UUID?

	init(noteId: UUID? = nil) {
		self.noteDataBaseManager = NoteDataBaseManager()
		self.rootView = NoteView()
		self.noteId = noteId

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.configureNavBar()

		self.view = self.rootView
		self.rootView.viewDidLoad()

		if let noteId {
			self.loadNote(with: noteId)
		}
		else {
			self.createNote()
		}
	}
}

private extension NoteViewController {
	func loadNote(with id: UUID) {
		let dbNote: Note

		if let tmp = self.noteDataBaseManager.getNoteById(id: id) {
			dbNote = tmp
		}
		else {
			dbNote = self.noteDataBaseManager.createNote(text: "")
		}

		let note = NoteModel(dbModel: dbNote)

		self.rootView.set(note: note)
	}

	func createNote() {
		let dbNote = self.noteDataBaseManager.createNote(text: "")
		let note = NoteModel(dbModel: dbNote)

		self.noteId = note.id
		self.rootView.set(note: note)
	}

	func configureNavBar() {
		let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.saveNote))
		let increaseFontSizeButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.increaseFontSize))
		let decreaseFontSizeButton = UIBarButtonItem(image: UIImage(systemName: "minus"), style: .plain, target: self, action: #selector(self.decreaseFontSize))

		self.navigationItem.rightBarButtonItems = [ saveButton, decreaseFontSizeButton, increaseFontSizeButton ]
	}

	@objc
	func saveNote() {
		let text = self.rootView.getText()

		if let noteId {
			self.noteDataBaseManager.editNoteById(id: noteId, newText: text)
		}

		self.navigationController?.popViewController(animated: true)
	}

	@objc
	func increaseFontSize() {
		self.rootView.increaseFontSize()
	}

	@objc
	func decreaseFontSize() {
		self.rootView.decreaseFontSize()
	}
}
