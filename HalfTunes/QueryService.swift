/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

// Runs query data task, and stores results in array of Tracks
class QueryService {

  typealias JSONDictionary = [String: Any]
  typealias QueryResult = ([Track]?, String) -> ()

  var tracks: [Track] = []
  var errorMessage = ""
  
  //1
  //Create URLSession and initialize with default session config
  let defaultSession = URLSession(configuration: .default)
  
  //2
  //Declare a URLSessionDataTask variable. Will be used to make a GET request to iTunes. Data task will be re-initialized every time the user enters a new search
  var dataTask: URLSessionDataTask?

  func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
    //1
    //Cancel data task if it already exists, so we can reuse the data task for this query
    dataTask?.cancel()
    //2
    //create search string. This method ensures characters in search string are escaped
    if var urlComponents = URLComponents(string: "https://itunes.apple.com/search"){
      urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
      //3
      //The url property of urlComponents may be nil, so optional-bind it to url
      guard let url = urlComponents.url else{ return}
      //4
      //Initialize a URLSessionDataTask with the query url and a completion handler
      dataTask = defaultSession.dataTask(with: url) { data, response, error in
        defer{ self.dataTask = nil}
      //5
        //if HTTP request succeeds, call helper method updateSearchResults(), which parses the response data into the tracks array
        if let error = error{ //if error is not nil
          self.errorMessage += "DataTask error: " + error.localizedDescription + "\n" //display error
        }else if let data = data, //if data is not nil , indicating HTTP request was successful
        let response = response as? HTTPURLResponse,
          response.statusCode == 200{
          self.updateSearchResults(data)
          //6
          //switch to the main queue to pass tracks to the completion handler
          DispatchQueue.main.async {
            completion(self.tracks, self.errorMessage)
        }
      }
    }
      //7
      //all tasks start in a suspended state by default, calling this starts the data task
    dataTask?.resume()
    }
  }

  fileprivate func updateSearchResults(_ data: Data) {
    var response: JSONDictionary?
    tracks.removeAll()

    do {
      response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    } catch let parseError as NSError {
      errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
      return
    }

    guard let array = response!["results"] as? [Any] else {
      errorMessage += "Dictionary does not contain results key\n"
      return
    }
    var index = 0
    for trackDictionary in array {
      if let trackDictionary = trackDictionary as? JSONDictionary,
        let previewURLString = trackDictionary["previewUrl"] as? String,
        let previewURL = URL(string: previewURLString),
        let name = trackDictionary["trackName"] as? String,
        let artist = trackDictionary["artistName"] as? String {
        tracks.append(Track(name: name, artist: artist, previewURL: previewURL, index: index))
        index += 1
      } else {
        errorMessage += "Problem parsing trackDictionary\n"
      }
    }
  }

}