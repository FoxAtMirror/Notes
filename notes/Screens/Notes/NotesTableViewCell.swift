//
//  NotesTableViewCell.swift
//  notes
//
//  Created by Владислав on 02.02.2024.
//

import UIKit

final class NotesTableViewCell: UITableViewCell {
	static let reuseIdentifier = "NotesTableCell"

	private enum Metrics {
		static let leadingOffset: CGFloat = 20
		static let trailingOffset: CGFloat = -40
		static let spacingBetweenLabels: CGFloat = 4
		static let verticalOffset: CGFloat = 8
	}

	private lazy var title: UILabel = {
		let label = UILabel(frame: .zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 16, weight: .bold)
		label.textAlignment = .left
		label.numberOfLines = 1
		label.lineBreakMode = .byTruncatingTail
		label.textColor = .label

		return label
	}()

	private lazy var subtitle: UILabel = {
		let label = UILabel(frame: .zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 14)
		label.textAlignment = .left
		label.lineBreakMode = .byTruncatingTail
		label.numberOfLines = 1
		label.textColor = .secondaryLabel
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.configureUI()
		self.configureLabels()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension NotesTableViewCell {
	func configure(with model: NoteModel) {
		self.title.text = model.text.isEmpty ? "Empty Note" : model.text
		self.subtitle.text = model.lastEditedDate.formatted()
		self.backgroundColor = .secondarySystemFill
	}
}

private extension NotesTableViewCell {
	func configureUI() {
		self.accessoryType = .disclosureIndicator
	}

	func configureLabels() {
		self.addSubview(self.title)
		self.addSubview(self.subtitle)

		NSLayoutConstraint.activate([
			self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.verticalOffset),
			self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingOffset),
			self.title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingOffset),
		])

		NSLayoutConstraint.activate([
			self.subtitle.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: Metrics.spacingBetweenLabels),
			self.subtitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingOffset),
			self.subtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingOffset),
			self.subtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.verticalOffset),
		])
	}
}
