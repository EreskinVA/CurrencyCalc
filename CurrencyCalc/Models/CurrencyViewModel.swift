//
//  CurrencyViewModel.swift
//  CurrencyCalc
//
//  Created by Admin on 14.11.2020.
//

final class CurrencyViewModel {
	let name: String
	let code: String
	let nominal: Int
	let value: Double
	var checked: Bool
	
	init(model: CurrencyModel) {
		name = model.name ?? ""
		code = model.charCode ?? ""
		nominal = model.nominal ?? 0
		value = model.value ?? 0
		checked = false
	}
}
