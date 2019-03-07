//
//  Temperature.swift
//  App
//
//  Created by sergey on 07/03/2019.
//

import FluentSQLite
import Vapor

enum TemperatureUnit: String, Encodable, Decodable {
  case celsius
  case fahrenheit
  case kelvin
}

final class Temperature: SQLiteModel {
  var id: Int?
  
  var value: Double
  
  var units: TemperatureUnit
  
  init(id: Int? = nil, value: Double, units: TemperatureUnit) {
    self.id = id
    self.value = value
    self.units = units
  }
}
/// Allows `Temperature` to be used as a dynamic migration.
extension Temperature: Migration { }

/// Allows `Temperature` to be encoded to and decoded from HTTP messages.
extension Temperature: Content { }

/// Allows `Temperature` to be used as a dynamic parameter in route definitions.
extension Temperature: Parameter { }

