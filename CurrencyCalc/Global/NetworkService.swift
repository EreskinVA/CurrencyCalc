//
//  NetworkService.swift
//  CurrencyCalc
//
//  Created by Admin on 14.11.2020.
//

import Foundation

final class NetworkService {
	func loadData(_ completion: @escaping (([String: CurrencyModel]) -> Void)) {
		guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else {
			DispatchQueue.main.async {
				completion([:])
			}
			return
		}
		
		URLSession.shared.dataTask(with: url) { (data, _, error) in
			guard let data = data, error == nil else { return }
			let decoder = JSONDecoder()
			do {
				let model = try? decoder.decode(ResponseModel.self, from: data)
				DispatchQueue.main.async {
					completion(model?.valute ?? [:])
				}
			}
		}.resume()
	}
}
