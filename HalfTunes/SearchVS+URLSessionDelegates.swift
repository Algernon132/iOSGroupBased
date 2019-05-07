//
//  SearchVS+URLSessionDelegates.swift
//  HalfTunes
//
//  Created by Chaz on 3/19/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import Foundation

extension SearchViewController: URLSessionDownloadDelegate{
  
  //This is the only non-functional method in URLSessionDownloadDelegate
  //Called when a download finishes
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL){
    //1
    //Extract the original request URL from the task
    guard let sourceURL = downloadTask.originalRequest?.url else{return}
    //look up the corresponding download in active downloads
    let download = downloadService.activeDownloads[sourceURL]
    //remove the URL from the active downloads library -- it isn't active any more.
    downloadService.activeDownloads[sourceURL] = nil
    //2
    //Pass the URL to the localFilePath(for:) helper method in SearchViewController.swift
    //Generates a permanent local file path to save to, by appending the lastPathComponent of the URL to the path of the app's Documents directory
    let destinationURL = localFilePath(for: sourceURL)
    print(destinationURL)
    //3
    //Using FileManager, move the downloaded file from its temp file location to the desired dest file path, first clearing out any item at that location before the copy.
    //Set the 'downloaded' property for that track to true
    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)
    do{
      try fileManager.copyItem(at: location, to: destinationURL)
      download?.track.downloaded = true
    }catch let error{
      print("Could not copy file to disk: \(error.localizedDescription)")
    }
    //4
    //Use the downloaded track's index property to reload the corresponding cell
    if let index = download?.track.index{
      DispatchQueue.main.async{
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
      }
    }
  }
}
