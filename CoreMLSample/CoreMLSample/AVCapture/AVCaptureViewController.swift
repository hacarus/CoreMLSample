import UIKit
import Vision
import AVFoundation
import CoreML

final class AVCaptureViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var viewModel: AVCaptureViewModel!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var captureSession: AVCaptureSession!
    private var detectLayer = CALayer()
    private var textLayer: CATextLayer!
    
    func inject(_ viewModel: AVCaptureViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Camera"
        setUpAVCapture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession.stopRunning()
    }
    
    lazy var modelRequest: VNCoreMLRequest = {
        guard let model = try? VNCoreMLModel(for: viewModel.mlModel) else {
            fatalError("can't load Core ML model")
        }
        return VNCoreMLRequest(model: model, completionHandler: self.handleModel)
    }()
    
    private func handleModel(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else { return }
        
        if let classification = results.first {
            var identifier = ""
            for text in classification.identifier {
                identifier.append(text)
                if text.description == "," {
                    identifier.append("\n")
                }
            }
            DispatchQueue.main.async {
                self.textLayer.string = "\(identifier)\n\n\(classification.confidence)"
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([self.modelRequest])
            } catch let error {
                print(error)
            }
        }
    }
    
    private func setUpAVCapture() {
        self.captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            fatalError("Could not set av capture device")
        }
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            fatalError("Could not set av capture device input")
        }
        
        captureSession.addInput(input)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.backgroundColor = UIColor.clear.cgColor
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        detectLayer.borderWidth = 4.0
        detectLayer.borderColor = UIColor.red.cgColor
        previewLayer.addSublayer(self.detectLayer)
        
        textLayer = CATextLayer()
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.fontSize = 14
        textLayer.frame = .init(x: 10, y: view.frame.size.height - 130, width: 200, height: 120)
        textLayer.backgroundColor = UIColor(red: 0.909, green: 0.904, blue: 0.913, alpha: 0.68).cgColor
        textLayer.isOpaque = false
        textLayer.cornerRadius = 6.0
        textLayer.masksToBounds = true
        textLayer.alignmentMode = kCAAlignmentCenter
        view.layer.addSublayer(textLayer)
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.init(label: "video"))
        captureSession.addOutput(dataOutput)
    }
}
