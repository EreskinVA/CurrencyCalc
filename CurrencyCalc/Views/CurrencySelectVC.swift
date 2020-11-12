//
//  CurrencySelectVC.swift
//  CurrencyCalc
//
//  Created by Admin on 11.11.2020.
//

import UIKit

/// Экран выбора валюты
final class CurrencySelectVC: UIViewController {
	
	private enum Constants {
		static let largeBarHeight: CGFloat = 91
		static let smallBarHeight: CGFloat = 44
	}
	
	var currencyDirection: CurrencyDirection?
	
	private let titleBarView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemGray6
		return view
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 18)
		label.text = "Выбор валют"
		return label
	}()
	
	private var cancelButtonItem: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		button.setTitleColor(.blue, for: .normal)
		button.setTitle("Отмена", for: .normal)
		
		button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
		return button
	}()
	
	private let tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		makeConstraints()
	}
	
	/// Закрыть экран
	@objc private func closeVC() {
		dismiss(animated: true)
	}
	
	private func setupViews() {
		view.backgroundColor = .white
		
		view.addSubviews(
			titleBarView,
			tableView
		)
		
		titleBarView.addSubviews(
			titleLabel,
			cancelButtonItem
		)
	}
	
	private func makeConstraints() {
		NSLayoutConstraint.activate([
			titleBarView.topAnchor.constraint(equalTo: view.topAnchor),
			titleBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			titleBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			titleBarView.heightAnchor.constraint(equalToConstant: Constants.smallBarHeight + UIApplication.statusBarHeight),
			
			titleLabel.heightAnchor.constraint(equalToConstant: 34),
			titleLabel.centerXAnchor.constraint(equalTo: titleBarView.centerXAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: titleBarView.bottomAnchor,
											   constant: -6),
			
			cancelButtonItem.heightAnchor.constraint(equalToConstant: 34),
			cancelButtonItem.trailingAnchor.constraint(equalTo: titleBarView.trailingAnchor, constant: -8),
			cancelButtonItem.bottomAnchor.constraint(equalTo: titleBarView.bottomAnchor,
													 constant: -6),
			
			tableView.topAnchor.constraint(equalTo: titleBarView.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
}
