import Vision
import UIKit

@available(iOS 13.0, *)
class HandPosePredictor {
    static func HandPoseClassifier() -> SignLangModel? {
    
        let defaultConfig = MLModelConfiguration()

        let signLangModelWrapper = try? SignLangModel(configuration: defaultConfig)

        guard let signLangModel = signLangModelWrapper else {
            fatalError("Ошибка создания модели")
        }

        let signLangModelModel = signLangModel.model
        
        return signLangModelWrapper
    }
}
