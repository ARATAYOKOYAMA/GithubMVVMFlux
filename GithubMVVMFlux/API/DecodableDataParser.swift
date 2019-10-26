//
//  DecodableDataParser.swift
//  HakodateSweets
//
//  Created by 横山新 on 2019/10/16.
//  Copyright © 2019 HakodateSweets. All rights reserved.
//

import Foundation
import APIKit

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}
