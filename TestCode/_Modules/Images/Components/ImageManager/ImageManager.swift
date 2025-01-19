//
//  ImageManager.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 19/1/25.
//

import UIKit

enum CompressType {
  case jpeg
  case png
}

protocol ImageManagerProtocol {
    func compressImage(image: UIImage, compressType: CompressType, quality: CGFloat?)
    func resizeImage(image: UIImage, maxWidth: CGFloat?, maxHeight: CGFloat?) -> UIImage?
}

class ImageManager: ImageManagerProtocol {
    var originalImage: UIImage?
    var dataImage: Data?
    var originalHeightInDots: CGFloat?
    var originalWidthInDots: CGFloat?
    var originalHeightInPixel: CGFloat?
    var originalWidthInPixel: CGFloat?
    var originalScale: CGFloat?

    /// This function allows you to compress your image with the type of crompression that you choose
    /// The options that you can choose are png or jpeg, in case you choose jpeg you can set the quality percentenge that you want,
    /// if you don´t set it the function apply always 0.8 being 1 the original quality
    public func compressImage(image: UIImage, compressType: CompressType, quality: CGFloat? = nil) {
        originalImage = image
        originalHeightInDots = image.size.height
        originalWidthInDots = image.size.width
        originalHeightInPixel = CGFloat(integerLiteral: image.cgImage?.height ?? 0)
        originalWidthInPixel = CGFloat(integerLiteral: image.cgImage?.width ?? 0)
        originalScale = image.scale

        switch compressType {
        case .jpeg:
            dataImage = compressToJPEG(image: image, quality: quality)
        case .png:
            dataImage = compressToPNG(image: image)
        }
    }

    /// This function allows you to resize the given image with the maximum size that you set
    public func resizeImage(image: UIImage, maxWidth: CGFloat? = 0, maxHeight: CGFloat? = 0) -> UIImage? {
        // Validar parámetros
        guard let maxWidth = maxWidth, maxWidth > 0 else {
            return image
        }

        guard let maxHeight = maxHeight, maxHeight > 0 else {
            return image
        }

        let originalWidth = image.size.width
        let originalHeight = image.size.height

        var newWidth: CGFloat = originalWidth
        var newHeight: CGFloat = originalHeight

        if maxWidth > maxHeight {
            let widthRatio = maxWidth / originalWidth
            newWidth = originalWidth * widthRatio
            newHeight = originalHeight * widthRatio
        } else {
            let heightRatio = maxHeight / originalHeight
            newHeight = originalHeight * heightRatio
            newWidth = originalWidth * heightRatio
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: CGSize(width: newWidth, height: newHeight)))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage
    }

    fileprivate func compressToJPEG(image: UIImage, quality: CGFloat?) -> Data? {
        return image.jpegData(compressionQuality: quality ?? 0.8)
    }

    fileprivate func compressToPNG(image: UIImage) -> Data? {
        return image.pngData()
    }
}
