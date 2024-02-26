//
//  NetworkService.swift
//  Weather
//
//  Created by Fed on 20.02.2024.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    func fetchData(completion: @escaping (Result<Double, Error>) -> Void) {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        
        guard let url = URL(string: urlString) else {
            debugPrint("Invalid URL")
            completion(.failure(NSError(domain: "NetworkService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let request = URLRequest(url: url)
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkService", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weather.currentWeather.temperature))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
