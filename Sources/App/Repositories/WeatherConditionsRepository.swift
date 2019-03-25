//
//  WeatherConditionsRepository.swift
//  App
//
//  Created by sergey on 07/03/2019.
//

import Foundation
import Vapor

enum WeatherConditionsRepositoryError: Error, LocalizedError {
  case noWeather
  case invalidPagingParams
  
  var errorDescription: String? {
    switch self {
    case .noWeather:
      return "The server could not return any weather"
    case .invalidPagingParams:
      return "Invalid paging params"
    }
  }
}


struct SimplePaginationRequest: Encodable, Decodable {
  var skip: Int
  var take: Int
}


struct WeatherFeedRequest {
  let paginationParameters: SimplePaginationRequest
}

protocol WeatherConditionsRepository: Service {
  func getCurrentWeather() throws -> WeatherConditions
  func getWeatherFeed(request: WeatherFeedRequest) throws -> [WeatherConditions]
}

class WeatherConditionsRepositoryImplementation: WeatherConditionsRepository {
  func getCurrentWeather() throws -> WeatherConditions {
    let conditions: WeatherConditions = WeatherConditions(id: nil,
                                                          temperature: Temperature(value: Double.random(in: -100...100),
                                                                                   units: .celsius))
    return conditions
  }
  
  func getWeatherFeed(request: WeatherFeedRequest) throws -> [WeatherConditions] {
    guard request.paginationParameters.skip >= 0,
      request.paginationParameters.take > request.paginationParameters.skip else {
      throw WeatherConditionsRepositoryError.invalidPagingParams
    }
    var result: [WeatherConditions] = []
    for _ in request.paginationParameters.skip ..< request.paginationParameters.take {
      let randomUnitsInt = Int.random(in: 0...2)
      if let randomUnits = TemperatureUnit(rawValue: randomUnitsInt) {
        result.append(WeatherConditions(id: nil,
                                        temperature: Temperature(value: Double.random(in: -100...100),
                                                                 units: randomUnits)))
      }
    }
    return result
  }
}
