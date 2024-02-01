//
//  NoteView.swift
//  notes
//
//  Created by Владислав on 02.02.2024.
//

import UIKit

protocol INoteView: UIView {
	func viewDidLoad()
	func set(note: NoteModel)
	func getText() -> String
	func increaseFontSize()
	func decreaseFontSize()
}

final class NoteView: UIView {
	private enum Metrics {
		static let textInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
	}

	private lazy var textView: UITextView = {
		let textView = UITextView(frame: .zero)
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = .systemFont(ofSize: 16)
		textView.textColor = .label
		textView.isEditable = true
		textView.backgroundColor = .systemBackground
		textView.isScrollEnabled = true
		textView.textAlignment = .left
		textView.textContainerInset = Metrics.textInsets

		return textView
	}()
}

extension NoteView: INoteView {
	func increaseFontSize() {
		self.textView.increaseFontSize()
	}
	
	func decreaseFontSize() {
		self.textView.decreaseFontSize()
	}
	
	func getText() -> String {
		self.textView.text
	}
	
	func set(note: NoteModel) {
		self.textView.text = note.text
	}
	
	func viewDidLoad() {
		self.configureUI()
		self.configureTextView()

		self.textView.becomeFirstResponder()
	}
}

private extension NoteView {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}

	func configureTextView() {
		self.addSubview(self.textView)
		NSLayoutConstraint.activate([
			self.textView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			self.textView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
			self.textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.textView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
	}
}

private extension UITextView {
	func increaseFontSize() {
		guard let fontPointSize = self.font?.pointSize
		else { return }

		self.font = .systemFont(ofSize: fontPointSize + 1)
	}

	func decreaseFontSize() {
		guard let fontPointSize = self.font?.pointSize
		else { return }

		self.font = .systemFont(ofSize: fontPointSize - 1)
	}
}
