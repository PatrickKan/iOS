//
//  HIUserService.swift
//  HackIllinois
//
//  Created by Rauhul Varma on 1/23/18.
//  Copyright © 2018 HackIllinois. All rights reserved.
//  This file is part of the Hackillinois iOS App.
//  The Hackillinois iOS App is open source software, released under the University of
//  Illinois/NCSA Open Source License. You should have received a copy of
//  this license in a file with the distribution.
//

import Foundation
import APIManager

final class HIUserService: HIBaseService {
    override static var baseURL: String {
        return super.baseURL + "/user"
    }

    static func getUser(by token: String, with loginMethod: HILoginMethod) -> APIRequest<HIAPIUser.Contained> {
        var headers = HTTPHeaders()
        switch loginMethod {
        case .github:
            headers["Authorization"] = "Bearer \(token)"
        case .userPass:
            headers["Authorization"] = "Basic \(token)"
        }
        return APIRequest<HIAPIUser.Contained>(service: self, endpoint: "", headers: headers, method: .GET)
    }
}
