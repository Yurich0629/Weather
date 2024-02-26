//
//  ViewController.swift
//  Weather
//
//  Created by Илья Десятов on 28.04.2023.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var getWeatherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside)
    }
    
    @objc func didTapGetWeatherButton() {
        NetworkService.shared.fetchData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.weatherLabel.text = String(data)
                }
            case .failure(let error):
                debugPrint("Error: \(error.localizedDescription)")
            }
        }
    }
}
