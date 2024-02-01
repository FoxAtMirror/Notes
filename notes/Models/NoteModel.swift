//
//  NoteModel.swift
//  notes
//
//  Created by Владислав on 01.02.2024.
//

import Foundation

struct NoteModel {
	let id: UUID
	var text: String
	let createdDate: Date
	let lastEditedDate: Date
}

extension NoteModel {
	init(dbModel: Note) {
		self.init(id: dbModel.id,
				  text: dbModel.text,
				  createdDate: dbModel.createdDate,
				  lastEditedDate: dbModel.lastEditedDate)
	}
}
