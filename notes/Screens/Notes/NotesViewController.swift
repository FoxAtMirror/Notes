//
//  NotesViewController.swift
//  notes
//
//  Created by Владислав on 01.02.2024.
//

import UIKit

final class NotesViewController: UIViewController {
	private let noteDataBaseManager: INoteDataBaseManager

	private let tableViewDataSource: INotesTableViewDataSource
	private let tableViewDelegate: INotesTableViewDelegate
	private let rootView: INotesView

	private let isFirstLaunch: Bool

	init() {
		self.noteDataBaseManager = NoteDataBaseManager()

		self.tableViewDataSource = NotesTableViewDataSource()
		self.tableViewDelegate = NotesTableViewDelegate()
		self.rootView = NotesView()

		self.isFirstLaunch = UserDefaults.standard.bool(forKey: "firstNoteCreated") == false

		super.init(nibName: nil, bundle: nil)

		self.rootView.setTableView(dataSource: self.tableViewDataSource, delegate: self.tableViewDelegate)
		self.configureHandlers()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		self.configureNavBar()

		self.view = self.rootView
		self.rootView.viewDidLoad()

		self.loadNotes()

		if self.isFirstLaunch {
			self.createFirstLaunchNote()
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.loadNotes()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.navigationBar.prefersLargeTitles = false
	}
}

private extension NotesViewController {
	func loadNotes() {
		let notes = self.noteDataBaseManager.getAllNotes().map { NoteModel(dbModel: $0) }

		self.tableViewDataSource.clearNotes()
		self.tableViewDataSource.addNotes(notes)
		self.rootView.reloadData()
	}

	func createFirstLaunchNote() {
		let sampleText = """
		Lorem ipsum dolor sit amet, ex vix novum aperiam necessitatibus.
		Nusquam oporteat qui eu.
		Ullum altera accommodare mel ad, mazim volutpat facilisis eos no.
		Et adhuc aliquam mel.
		"""

		let dbNote = self.noteDataBaseManager.createNote(text: sampleText)
		let note = NoteModel(dbModel: dbNote)

		UserDefaults.standard.set(true, forKey: "firstNoteCreated")

		self.tableViewDataSource.addNotes([note])
		self.rootView.reloadData()
	}

	func configureNavBar() {
		self.navigationItem.title = "Notes"
		self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "square.and.pencil"), style: .done, target: self, action: #selector(self.createNewNote))
	}

	func configureHandlers() {
		self.tableViewDelegate.didSelectHandler = { [weak self] row in
			guard let self else { return }

			let note = self.tableViewDataSource.notes[row]

			self.navigateToNote(with: note.id)
		}

		self.tableViewDelegate.didRemoveCellHandler = { [weak self] indexPath in
			guard let self else { return }

			let note = self.tableViewDataSource.notes[indexPath.row]

			self.noteDataBaseManager.deleteNoteById(id: note.id)
			self.tableViewDataSource.removeNote(at: indexPath.row)
			self.rootView.deleteRow(at: indexPath)
		}
	}

	@objc
	func createNewNote() {
		self.presentNoteViewController(noteId: nil)
	}

	func navigateToNote(with id: UUID) {
		self.presentNoteViewController(noteId: id)
	}

	func presentNoteViewController(noteId: UUID?) {
		let noteViewController = NoteViewController(noteId: noteId)

		self.navigationController?.pushViewController(noteViewController, animated: true)
	}
}
