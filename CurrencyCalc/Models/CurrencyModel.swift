//
//  CurrencyModel.swift
//  CurrencyCalc
//
//  Created by Admin on 11.11.2020.
//

struct CurrencyModel: Codable {
	let iD: String?
	let numCode: String?
	let charCode: String?
	let nominal: Int?
	let name: String?
	let value: Double?
	let previous: Double?

	enum CodingKeys: String, CodingKey {
		case iD = "ID"
		case numCode = "NumCode"
		case charCode = "CharCode"
		case nominal = "Nominal"
		case name = "Name"
		case value = "Value"
		case previous = "Previous"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		iD = try values.decodeIfPresent(String.self, forKey: .iD)
		numCode = try values.decodeIfPresent(String.self, forKey: .numCode)
		charCode = try values.decodeIfPresent(String.self, forKey: .charCode)
		nominal = try values.decodeIfPresent(Int.self, forKey: .nominal)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		value = try values.decodeIfPresent(Double.self, forKey: .value)
		previous = try values.decodeIfPresent(Double.self, forKey: .previous)
	}

}

