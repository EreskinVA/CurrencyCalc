//
//  UIView+Extension.swift
//  CurrencyCalc
//
//  Created by Admin on 11.11.2020.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach { view in
			self.addSubview(view)
		}
	}
}
