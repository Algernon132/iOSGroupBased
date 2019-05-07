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

// Downloads song snippets, and stores in local file.
// Allows cancel, pause, resume download.
class DownloadService {

  //This dictionary maintains a mapping between a URL and its active Download, if any
  var activeDownloads: [URL: Download] = [:]
  
  // SearchViewController creates downloadsSession
  var downloadsSession: URLSession!

  // MARK: - Download methods called by TrackCell delegate methods

  //Called when a user taps the table view cell's Download button.
  //SearchViewController, acting as TrackCellDelegate, identifies the Track for the cell, then calls this function with the proper track.
  func startDownload(_ track: Track) {
    //1
    //Initialize a Download with the track.
    let download = Download(track: track)
    //2
    //Using our new session object, create a URLSessionDownloadTask w/ the track's privew URL. Set it to the task property of the download
    download.task = downloadsSession.downloadTask(with: track.previewURL)
    //3
    //Start the download task
    download.task!.resume()
    //4
    //Indicate download is in progress
    download.isDownloading = true
    //5
    //Map the download URL to its Download in the activeDownloads dictionaryb
    activeDownloads[download.track.previewURL] = download
  }
  // TODO: previewURL is http://a902.phobos.apple.com/...
  // why doesn't ATS prevent this download?

  func pauseDownload(_ track: Track) {
    // TODO
  }

  func cancelDownload(_ track: Track) {
    // TODO
  }

  func resumeDownload(_ track: Track) {
    // TODO
  }

}
