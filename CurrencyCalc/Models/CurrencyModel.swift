//
//  CurrencyModel.swift
//  CurrencyCalc
//
//  Created by Admin on 11.11.2020.
//

struct CurrencyModel: Codable {
	let ID: String
	let NumCode: String
	let CharCode: String
	let Nominal: Int
	let Name: String
	let Value: Double
	let Previous: Double
}
