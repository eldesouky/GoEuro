//
//  Double+Format.swift
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

import Foundation

//MARK:- Number of Decimals
extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}