//
//  Int+Format.swift
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

import Foundation

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}
