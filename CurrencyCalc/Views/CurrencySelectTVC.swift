//
//  CurrencySelectTVC.swift
//  CurrencyCalc
//
//  Created by Admin on 14.11.2020.
//

import UIKit

final class CurrencySelectTVC: UITableViewCell {
	
	private var nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.font = UIFont.boldSystemFont(ofSize: 32)
		return label
	}()
	
	private var codeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 32)
		label.textColor = .gray
		return label
	}()
	
	private var checkImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "check"))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.isHidden = true
		return imageView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupViews()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		nameLabel.text = nil
		codeLabel.text = nil
		checkImageView.isHidden = true
	}
	
	func update(with model: CurrencyViewModel) {
		nameLabel.text = model.name
		codeLabel.text = model.code
		checkImageView.isHidden = !model.checked
	}
	
	private func setupViews() {
		contentView.addSubviews(
			nameLabel,
			codeLabel,
			checkImageView
		)
	}
	
	private func makeConstraints() {
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
										   constant: 16),
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
			nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			
			codeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
										   constant: 16),
			codeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
			codeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			codeLabel.widthAnchor.constraint(equalToConstant: 80),
			
			checkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			checkImageView.leadingAnchor.constraint(equalTo: codeLabel.trailingAnchor,
													constant: 16),
			checkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
			checkImageView.widthAnchor.constraint(equalToConstant: 32),
			checkImageView.heightAnchor.constraint(equalToConstant: 32)
		])
	}
}
