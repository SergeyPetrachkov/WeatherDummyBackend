//
//  WeatherController.swift
//  App
//
//  Created by sergey on 06/03/2019.
//

import Vapor
enum WeatherErrors: Error {
  case randomError
}
final class WeatherController {
  /// Returns random weather.
  func index(_ req: Request) throws -> WeatherConditions {
    return WeatherConditions(id: nil, temperature: Double.random(in: -100...100))
  }
}
