//
//  UIApplication+Extension.swift
//  CurrencyCalc
//
//  Created by Admin on 12.11.2020.
//

import UIKit

extension UIApplication {
	static var statusBarHeight: CGFloat {
		var statusBarHeight: CGFloat = 0
		if #available(iOS 13.0, *) {
			let window = shared.windows.filter { $0.isKeyWindow }.first
			statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
		} else {
			statusBarHeight = shared.statusBarFrame.height
		}
		return statusBarHeight
	}
}
