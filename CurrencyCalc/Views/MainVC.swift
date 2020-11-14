//
//  MainVC.swift
//  CurrencyCalc
//
//  Created by Admin on 11.11.2020.
//

import UIKit

/// Тип валюты выбранного направления
enum CurrencyDirection {
	case from
	case to
	case none
}

/// Основной экран
final class MainVC: UIViewController {
	
	private enum Constants {
		static let spacing: CGFloat = 64
		static let currencyValueFontSize: CGFloat = 28
		static let currencyNameFontSize: CGFloat = 32
		static let changeButtonFontSize: CGFloat = 24
		
		static let sideOffset: CGFloat = 20
		static let topOffset: CGFloat = 30
		
		static let stackWidth: CGFloat = 100
		
		static let buttonWidth: CGFloat = 120
		static let buttonHeight: CGFloat = 64
		static let buttonTopOffset: CGFloat = 44
	}
	
	var valutes: [CurrencyViewModel] = []
	
	/// Текущий объем валюты который переводим
	private let fromCurrencyTF: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.font = UIFont.boldSystemFont(ofSize: Constants.currencyValueFontSize)
		textField.text = "0"
		return textField
	}()
	
	/// Объем валюты который получаем
	private let toCurrencyTF: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.font = UIFont.boldSystemFont(ofSize: Constants.currencyValueFontSize)
		textField.text = "0"
		return textField
	}()
	
	/// Валюта с которой переводим
	private let fromCurrencyLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: Constants.currencyNameFontSize)
		label.text = "-"
		return label
	}()
	
	/// Валюта в которую переводим
	private let toCurrencyLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: Constants.currencyNameFontSize)
		label.text = "-"
		return label
	}()
	
	/// Кнопка изменения валюты с которой переводим
	private let fromCurrencyButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tag = 1
		button.setTitleColor(.blue, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.changeButtonFontSize)
		button.titleLabel?.lineBreakMode = .byWordWrapping
		button.titleLabel?.textAlignment = .center
		button.setTitle("Изменить валюту", for: .normal)
		
		button.addTarget(self, action: #selector(goToChangeCurrency(_:)), for: .touchUpInside)
		return button
	}()
	
	/// Кнопка перевода валюты в которую переводим
	private let toCurrencyButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tag = 2
		button.setTitleColor(.blue, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.changeButtonFontSize)
		button.titleLabel?.lineBreakMode = .byWordWrapping
		button.titleLabel?.textAlignment = .center
		button.setTitle("Изменить валюту", for: .normal)
		
		button.addTarget(self, action: #selector(goToChangeCurrency(_:)), for: .touchUpInside)
		return button
	}()
	
	/// Картинка "стрелка" посередине
	private let imageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "arrow"))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	private let fromStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = Constants.spacing
		return stackView
	}()
	
	private let toStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = Constants.spacing
		return stackView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		makeConstraints()
		NetworkService().loadData { model in
			guard !model.isEmpty else {
				self.valutes = []
				self.updateData(with: nil, direction: .none)
				return
			}
			self.valutes = model.compactMap { CurrencyViewModel(model: $0.value) }
			self.updateData(with: nil, direction: .none)
		}
	}
	
	/// Перейти на экран выбора валюты
	/// - Parameter sender: кнопка вызывающая метод
	@objc private func goToChangeCurrency(_ sender: UIButton) {
		let currencySelectVC = CurrencySelectVC()
		currencySelectVC.currencyDirection = sender.tag == 1 ? .from : .to
		currencySelectVC.viewModels = valutes
		currencySelectVC.delegate = self
		currencySelectVC.modalPresentationStyle = .fullScreen
		navigationController?.present(currencySelectVC, animated: true)
	}
	
	/// Настраиваем вьюхи
	private func setupViews() {
		title = "Конвертер валют"
		
		view.backgroundColor = .white
		
		fromStackView.addArrangedSubview(fromCurrencyTF)
		fromStackView.addArrangedSubview(fromCurrencyLabel)
		
		toStackView.addArrangedSubview(toCurrencyTF)
		toStackView.addArrangedSubview(toCurrencyLabel)
		
		view.addSubviews(
			fromStackView,
			toStackView,
			imageView,
			fromCurrencyButton,
			toCurrencyButton
		)
	}
	
	/// Создаем констреинты
	private func makeConstraints() {
		NSLayoutConstraint.activate([
			fromStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
											   constant: Constants.topOffset),
			fromStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
												   constant: Constants.sideOffset),
			fromStackView.widthAnchor.constraint(equalToConstant: Constants.stackWidth),
			
			toStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
											 constant: Constants.topOffset),
			toStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
												  constant: -Constants.sideOffset),
			toStackView.widthAnchor.constraint(equalToConstant: Constants.stackWidth),
			
			imageView.heightAnchor.constraint(equalToConstant: 32),
			imageView.centerYAnchor.constraint(equalTo: fromStackView.centerYAnchor),
			imageView.leadingAnchor.constraint(equalTo: fromStackView.trailingAnchor),
			imageView.trailingAnchor.constraint(equalTo: toStackView.leadingAnchor),
			
			fromCurrencyButton.topAnchor.constraint(equalTo: fromStackView.bottomAnchor,
													constant: Constants.buttonTopOffset),
			fromCurrencyButton.centerXAnchor.constraint(equalTo: fromStackView.centerXAnchor),
			fromCurrencyButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
			fromCurrencyButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
			
			toCurrencyButton.topAnchor.constraint(equalTo: toStackView.bottomAnchor,
												  constant: Constants.buttonTopOffset),
			toCurrencyButton.centerXAnchor.constraint(equalTo: toStackView.centerXAnchor),
			toCurrencyButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
			toCurrencyButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
		])
	}
	
	func updateData(with viewModel: CurrencyViewModel?, direction: CurrencyDirection) {
		switch direction {
		case .from:
			fromCurrencyLabel.text = viewModel?.code ?? "-"
			fromCurrencyTF.text = "0"
		case .to:
			toCurrencyLabel.text = viewModel?.code ?? "-"
			toCurrencyTF.text = "0"
		case .none:
			fromCurrencyLabel.text = viewModel?.code ?? "-"
			fromCurrencyTF.text = "0"
			toCurrencyLabel.text = "-"
			toCurrencyTF.text = "0"
		}
		
	}
}

