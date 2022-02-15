//
//  ServerModelTypeRes.swift
//  CarSelect
//
//  Created by Django on 2/8/22.
//

import Foundation

public protocol ServerModelTypeRes: Codable { }
extension Optional: ServerModelTypeRes where Wrapped: ServerModelTypeRes { }
