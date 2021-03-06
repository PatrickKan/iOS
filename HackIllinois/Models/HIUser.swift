//
//  HIUser.swift
//  HackIllinois
//
//  Created by Rauhul Varma on 1/14/18.
//  Copyright © 2018 HackIllinois. All rights reserved.
//  This file is part of the Hackillinois iOS App.
//  The Hackillinois iOS App is open source software, released under the University of
//  Illinois/NCSA Open Source License. You should have received a copy of
//  this license in a file with the distribution.
//
import Foundation
import SwiftKeychainAccess
import APIManager

enum HILoginMethod: Int, Codable {
    case github
    case userPass
}

enum HILoginSelection: Int {
    case github
    case userPass
    case existing
}

enum HIUserPermissions: String, Codable, Comparable {
    case guest = "GUEST"
    case attendee = "ATTENDEE"
    case volunteer = "VOLUNTEER"
    case mentor = "MENTOR"
    case sponsor = "SPONSOR"
    case staff = "STAFF"
    case admin = "ADMIN"

    private var intValue: Int {
        switch self {
        case .admin: return 5
        case .staff: return 4
        case .sponsor: return 3
        case .mentor: return 2
        case .volunteer: return 1
        case .attendee: return 0
        case .guest: return -1
        }
    }

    static func < (lhs: HIUserPermissions, rhs: HIUserPermissions) -> Bool {
        return lhs.intValue < rhs.intValue
    }
}

enum HIDietaryRestrictions: String, Codable {
    case none = "NONE"
    case vegetarian = "VEGETARIAN"
    case vegan = "VEGAN"
    case glutenFree = "GLUTEN_FREE"

    var displayText: String {
        switch self {
        case .none: return "NO DIETARY RESTRICTIONS"
        case .vegetarian: return "VEGETARIAN"
        case .vegan: return "VEGAN"
        case .glutenFree: return "GLUTEN FREE"
        }
    }
}

struct HIUser: Codable {
    var loginMethod: HILoginMethod
    var permissions: HIUserPermissions
    var token: String
    var identifier: String
    var isActive: Bool
    var id: Int

    var name: String?
    var dietaryRestrictions: HIDietaryRestrictions?
}

// MARK: - DataConvertible
extension HIUser: DataConvertible {
    init?(data: Data) {
        do {
            self = try JSONDecoder().decode(HIUser.self, from: data)
        } catch {
            return nil
        }
    }

    var data: Data {
        let encoded = try? JSONEncoder().encode(self)
        return encoded ?? Data()
    }
}

// MARK: - APIAuthorization
extension HIUser: APIAuthorization {
    public func headersFor<ReturnType>(request: APIRequest<ReturnType>) -> HTTPHeaders {
        var headers = HTTPHeaders()
        switch loginMethod {
        case .github:
            headers["Authorization"] = "Bearer \(token)"
        case .userPass:
            headers["Authorization"] = "Basic \(token)"
        }
        return headers
    }
}
