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
  
  func getWeatherFeed(_ req: Request) throws -> Future<[WeatherConditions]> {
    do {
      guard let data = req.http.body.data else {
        throw WeatherConditionsRepositoryError.invalidPagingParams
      }
      let pagingParams = try JSONDecoder().decode(SimplePaginationRequest.self, from: data)
      
      let repository = try req.sharedContainer.make(WeatherConditionsRepository.self)
      
      let weather = try repository.getWeatherFeed(request: WeatherFeedRequest(paginationParameters: pagingParams))
      let promisedWeather = req.eventLoop.newPromise((Array<WeatherConditions>).self)
      sleep(3)
      promisedWeather.succeed(result: weather)
      return promisedWeather.futureResult
    } catch let error {
      throw error
    }
  }
}
