//
//  WeatherConditionsRepository.swift
//  App
//
//  Created by sergey on 07/03/2019.
//

import Foundation
import Vapor

enum WeatherConditionsRepositoryError: Error {
  case noWeather
}
protocol WeatherConditionsRepository: Service {
  func getCurrentWeather() throws -> WeatherConditions
}

class WeatherConditionsRepositoryImplementation: WeatherConditionsRepository {
  func getCurrentWeather() throws -> WeatherConditions {
    let conditions: WeatherConditions = WeatherConditions(id: nil,
                                                          temperature: Temperature(value: Double.random(in: -100...100),
                                                                                   units: .celsius))
    return conditions
  }
}
