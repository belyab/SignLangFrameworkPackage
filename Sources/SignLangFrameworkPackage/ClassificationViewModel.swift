import Foundation
import Vision

@available(iOS 13.0, *)
@available(iOS 14.0, *)
@available(iOS 15.0, *)
@available(iOS 16.0, *)
public class ClassificationViewModel {
    
    internal var model: SignLangModel?
    internal var result: SignLangModelOutput?
    public let handPoseRequest = VNDetectHumanHandPoseRequest()
    
    public init() {}
    
    public func classify() {
        handPoseRequest.maximumHandCount = 1
        
        guard let model = HandPosePredictor.HandPoseClassifier() else {
            print("error")
            return
        }

        self.model = model
        
    }
    
    public func predictResult(handler: VNImageRequestHandler) {
     
        do {
            try handler.perform([handPoseRequest])
            guard let observation = handPoseRequest.results?.first else {
                print("Нет данных")
                return
            }
            
            result = try model?.prediction(poses: observation.keypointsMultiArray())
            print("[Prediction] \(result?.label ?? "ошибка")")
        } catch {
            print("Ошибка \(error)")
        }
    }

}
