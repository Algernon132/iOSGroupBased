//
//  ViewController.swift
//  MediaUploadTest
//
//  Created by Thomas Jurczyk on 5/12/19.
//  Copyright © 2019 Thomas Jurczyk. All rights reserved.
//

import UIKit
import Cloudinary

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

open class ImagePicker: NSObject {
    
    let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "dnceabf52", apiSecret: "oe9TSfe2e-_tKV7wE7tMRkxCNkM", secure: true))
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image)
        //BELOW ARE THE MOST BASIC STEPS FOR IMAGE UPLOAD. WE FIRST CONVERT THE IMAGE INTO RAW DATA
        guard let dataImage=image?.jpegData(compressionQuality: 1) else {return}
        //NEXT, WE CREATE AN UPLOAD OBJECT AND UPLOAD THE IMAGE
        let request = cloudinary.createUploader().upload(data: dataImage, uploadPreset: "normalupload")
        request.response { (result, error) in
            //THE BELOW URL IS A DIRECT, UNIQUE LINK TO THE UPLOADED MEDIA FILE
            print(result?.url)
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "dnceabf52", apiSecret: "oe9TSfe2e-_tKV7wE7tMRkxCNkM", secure: true))
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
    }
    @IBAction func downloadImageAction(_ sender: Any) {
        //THIS IS THE FUNCTION FOR DOWNLOADING AN IMAGE. URL WILL BE REPLACED WITH WHATEVER URLs ARE STORED IN THE DATABASE
        let URL="https://res.cloudinary.com/dnceabf52/image/upload/v1557712070/iOSProject/Screen_Shot_2019-05-09_at_1.52.40_PM_q6padk.png"
        let downloader = cloudinary.createDownloader().fetchImage(URL) { (image, error) in
            self.imageView.image=image
            // image is an instance UIImage
            // error is an instance of NSError
        }
    }
    @IBAction func showImagePicker(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
    }

}
extension ViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}