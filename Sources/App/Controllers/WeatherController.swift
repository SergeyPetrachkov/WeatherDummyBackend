//
//  WeatherController.swift
//  App
//
//  Created by sergey on 06/03/2019.
//

import Vapor
enum WeatherErrors: Error {
  case couldNotResolveContainer
}
final class WeatherController {
  
  /// Returns random weather.
  func index(_ req: Request) throws -> Future<WeatherConditions> {
    do {
      let promisedWeather = req.eventLoop.newPromise(WeatherConditions.self)
      
      let repository = try req.sharedContainer.make(WeatherConditionsRepository.self)
      let weather = try repository.getCurrentWeather()
      sleep(3)
      promisedWeather.succeed(result: weather)      
      return promisedWeather.futureResult
    } catch let error {
      throw error
    }
  }
}
