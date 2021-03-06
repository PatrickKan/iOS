//
//  HIRegistrationService.swift
//  HackIllinois
//
//  Created by Rauhul Varma on 2/7/18.
//  Copyright © 2018 HackIllinois. All rights reserved.
//  This file is part of the Hackillinois iOS App.
//  The Hackillinois iOS App is open source software, released under the University of
//  Illinois/NCSA Open Source License. You should have received a copy of
//  this license in a file with the distribution.
//

import Foundation
import APIManager

final class HIRegistrationService: HIBaseService {
    override static var baseURL: String {
        return super.baseURL + "/registration"
    }

    static func getAttendee(by token: String, with loginMethod: HILoginMethod) -> APIRequest<HIAPIAttendee.Contained> {
        var headers = HTTPHeaders()
        switch loginMethod {
        case .github:
            headers["Authorization"] = "Bearer \(token)"
        case .userPass:
            headers["Authorization"] = "Basic \(token)"
        }
        return APIRequest<HIAPIAttendee.Contained>(service: self, endpoint: "/attendee", headers: headers, method: .GET)
    }
}
