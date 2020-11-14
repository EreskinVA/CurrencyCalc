//
//  ResponseModel.swift
//  CurrencyCalc
//
//  Created by Admin on 11.11.2020.
//

import Foundation

struct ResponseModel: Codable {
	let date: String?
	let previousDate: String?
	let previousURL: String?
	let timestamp: String?
	let valute: [String: CurrencyModel]

	enum CodingKeys: String, CodingKey {
		case date = "Date"
		case previousDate = "PreviousDate"
		case previousURL = "PreviousURL"
		case timestamp = "Timestamp"
		case valute = "Valute"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		previousDate = try values.decodeIfPresent(String.self, forKey: .previousDate)
		previousURL = try values.decodeIfPresent(String.self, forKey: .previousURL)
		timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
		valute = try values.decodeIfPresent([String: CurrencyModel].self, forKey: .valute) ?? [:]
	}
}
