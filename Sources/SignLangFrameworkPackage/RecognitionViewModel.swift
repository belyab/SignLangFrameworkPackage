import Foundation
import UIKit
import Speech

public class RecognitionViewModel {
    
    public let audioEngine = AVAudioEngine()
    public let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU"))
    public var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    public var recognitionTask: SFSpeechRecognitionTask?
    public var bestString: String?
    
    public func settings() {
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            buffer, _ in self.recognitionRequest.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        guard let myRecognaizer = SFSpeechRecognizer() else {
            return
        }
        if !myRecognaizer.isAvailable {
            return
        }
    }
    
    public func startRecognition(textView: UITextView) -> String? {
        settings()
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { result, error in
            if let result = result {
                self.bestString = result.bestTranscription.formattedString
                textView.text = self.bestString
            } else if let error = error {
                print(error)
            }
        })
        return self.bestString
    }
    
    public func stopRecognition() {
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        recognitionRequest.endAudio()
    }
}

