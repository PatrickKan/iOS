//
//  HIPassService.swift
//  HackIllinois
//
//  Created by Yasha Mostofi on 2/22/18.
//  Copyright © 2018 HackIllinois. All rights reserved.
//  This file is part of the Hackillinois iOS App.
//  The Hackillinois iOS App is open source software, released under the University of
//  Illinois/NCSA Open Source License. You should have received a copy of
//  this license in a file with the distribution.
//

import Foundation
import APIManager
import SafariServices

final class HIPassService: HIBaseService {
    override static var baseURL: String {
        return "https://passgen.hackillinois.org/pkpass"
    }

    static func getPass(with msg: String) -> APIRequest<Data> {
        let params: HTTPBody = [
            "message": msg
        ]
        return APIRequest<Data>(service: self, endpoint: "", body: params, method: .POST)
    }
}

extension Data: APIReturnable {
    public init(from data: Data) throws {
        self = data
    }
}
