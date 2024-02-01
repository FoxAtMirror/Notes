//
//  NoteDataBaseManager.swift
//  notes
//
//  Created by Владислав on 02.02.2024.
//

import CoreData
import Foundation

protocol INoteDataBaseManager {
	func createNote(text: String) -> Note
	func getAllNotes() -> [Note]
	func getNoteById(id: UUID) -> Note?
	func editNoteById(id: UUID, newText: String)
	func deleteNoteById(id: UUID)
}

class NoteDataBaseManager {
	private lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "notes")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	private var context: NSManagedObjectContext {
		self.persistentContainer.viewContext
	}

	init() {}
}

extension NoteDataBaseManager: INoteDataBaseManager {
	func createNote(text: String) -> Note {
		let newNote = Note(context: self.context)
		newNote.id = UUID()
		newNote.text = text
		newNote.createdDate = Date()
		newNote.lastEditedDate = Date()
		self.saveContext()
		return newNote
	}

	func getAllNotes() -> [Note] {
		let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()

		do {
			let notes = try self.context.fetch(fetchRequest)
			return notes
		} catch {
			print("Error while get notes: \(error)")
			return []
		}
	}

	func getNoteById(id: UUID) -> Note? {
		let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

		do {
			let notes = try self.context.fetch(fetchRequest)
			return notes.first
		} catch {
			print("Error while get note by id: \(error)")
			return nil
		}
	}

	func editNoteById(id: UUID, newText: String) {
		if let noteToEdit = self.getNoteById(id: id) {
			noteToEdit.text = newText
			noteToEdit.lastEditedDate = Date()
			self.saveContext()
		} else {
			print("Note with id - \(id) not founded")
		}
	}

	func deleteNoteById(id: UUID) {
		if let noteToDelete = self.getNoteById(id: id) {
			self.context.delete(noteToDelete)
			self.saveContext()
		} else {
			print("Note with id - \(id) not founded")
		}
	}
}

private extension NoteDataBaseManager {
	func saveContext() {
		if self.context.hasChanges {
			do {
				try self.context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
