//
//  ResponseModel.swift
//  CurrencyCalc
//
//  Created by Admin on 11.11.2020.
//

import Foundation

struct ResponseModel: Codable {
	let Date: Date
	let PreviousDate: Date
	let PreviousURL: URL
	let Timestamp: Date
	let Valute: [String: CurrencyModel]
}
