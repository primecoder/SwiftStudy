
import Foundation
import PlaygroundSupport

import Alamofire
import SwiftyJSON

var str = "Hello, playground"

guard let url = URL(string: "http://demo3511160.mockable.io/hellox") else {
    exit(0)
}

//: Traditional way (not using Alamofire and SwiftyJSON).
let urlSession = URLSession.shared
let getReq = URLRequest(url: url)
let task = urlSession.dataTask(with: getReq) { (data, response, error) in
    print("(Req Handler) Request Handler Here")

    guard error == nil else {
        print("(Req Handler) Error: \(error)")
        return
    }

    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        print("(Req Handler) Error. Status Code not 200")
        return
    }

    guard let data = data else { return }

    print("(Req Handler) Response: \(String(describing: response))")

    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
        print("(Req Handler) Data: \(json)")

        // Access individual property.
        if let msg = json["msg"] {
            print("(Req Handler) Message: \(msg)")
        }
    }
}
task.resume()


//: Using Alamofire + SwiftyJSON
print("---")
Alamofire.request(url).responseJSON { (responseJson) in
    print("(Alamofire) Request: \(String(describing: responseJson.request))")
    print("(Alamofire) Response: \(String(describing: responseJson.response))")

    guard responseJson.error == nil else {
        print("(Alamofire) Error: \(responseJson.error)")
        exit(0)
    }

    guard let json = responseJson.result.value else {
        exit(0)
    }

    // Using SwiftyJSON
    print("(Alamofire) ---")
    let swiftyJson = JSON(json)
    print("(Alamofire) Result (json): \(json)")
    print("(Alamofire) Message: \(swiftyJson["msg"])")  // Access individual property
}
