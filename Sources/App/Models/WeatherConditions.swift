//
//  WeatherConditions.swift
//  App
//
//  Created by sergey on 06/03/2019.
//

import Vapor
import FluentSQLite

final class WeatherConditions: SQLiteModel {
  /// The unique identifier for this `WeatherConditions`.
  var id: Int?
  
  /// A temperature parameter, let's keep it simple for now
  var temperature: Temperature
  
  /// Creates a new `WeatherConditions`.
  init(id: Int? = nil, temperature: Temperature) {
    self.id = id
    self.temperature = temperature
  }
}
/// Allows `WeatherConditions` to be used as a dynamic migration.
extension WeatherConditions: Migration { }

/// Allows `WeatherConditions` to be encoded to and decoded from HTTP messages.
extension WeatherConditions: Content { }

/// Allows `WeatherConditions` to be used as a dynamic parameter in route definitions.
extension WeatherConditions: Parameter { }
