//
//  ListPhotosViewController.swift
//  MakeSchoolNotes
//
//  Created by Thomas Jurczyk on 5/14/19.
//  Copyright © 2019 MakeSchool. All rights reserved.
//

import UIKit
import Cloudinary

let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "dnceabf52", apiSecret: "oe9TSfe2e-_tKV7wE7tMRkxCNkM", secure: true))

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

open class ImagePicker: NSObject {
    
    //let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "dnceabf52", apiSecret: "oe9TSfe2e-_tKV7wE7tMRkxCNkM", secure: true))
    
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
                                      didFinishPickingMediaWithInfo ixznfo: [UIImagePickerController.InfoKey: Any]) {
        guard let image = ixznfo[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}

private let reuseIdentifier = "Cell"

class ListPhotosViewController: UICollectionViewController {
    
    //let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "dnceabf52", apiSecret: "oe9TSfe2e-_tKV7wE7tMRkxCNkM", secure: true))
    
    var imagePicker: ImagePicker!
    
    @IBOutlet var currentView: UIView!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    
    //NORMALLY THERE WOULD BE A DATABASE CALL HERE, BUT AT THIS POINT WE HAVE NOT YET IMPLEMENTED THIS FUNCTIONALITY, SO WHAT FOLLOWS IS ONLY AN ARRAY OF PRE-CREATED IMAGE URLs TO DEMONSTRATE THE CLOUD IMAGE FUNCTION
    let sampleImgArray=["https://res.cloudinary.com/dnceabf52/image/upload/v1557877196/iOSProject/lx0aybhbublxrhsqdxw3.jpg","https://res.cloudinary.com/dnceabf52/image/upload/v1557877442/iOSProject/vvmagvuhcquq0p8hro8i.jpg","https://res.cloudinary.com/dnceabf52/image/upload/v1557705556/iOSProject/lnda969ht9yotukohlbc.jpg","https://res.cloudinary.com/dnceabf52/image/upload/v1557712070/iOSProject/Screen_Shot_2019-05-09_at_1.52.40_PM_q6padk.png"]
    var CellUIImageArray:[UIImageView]=[]
    var isComplete:Bool=false
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sampleImgArray.count
    }
    @IBAction func addPhoto(_ sender: Any) {
        self.imagePicker.present(from: currentView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        
        if let cell=cell as? PhotoCollectionViewCell
        {
            CellUIImageArray.append(cell.photoContents)
        }
        if(indexPath.item==sampleImgArray.count-1)
        {
            downloadImage(URLsToDownload: sampleImgArray, Images: CellUIImageArray)
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as! ImagePickerDelegate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        guard let identifier = segue.identifier else { return }
        
        // 2
        if identifier == "photos" {
            print("Transitioning to the Display Note View Controller")
        }
    }
    func downloadImage(URLsToDownload:[String], Images:[UIImageView])
    {
        for (index,currentURL) in URLsToDownload.enumerated()
        {
            cloudinary.createDownloader().fetchImage(currentURL) { (image, error) in
                Images[index].image=image
                print(error)
                // image is an instance UIImage
                // error is an instance of NSError
            }
        }
    }
    
}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
extension ListPhotosViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        //self.imageView.image = image
    }
}
