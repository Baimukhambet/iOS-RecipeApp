import Foundation
import UIKit

extension AsyncOperation {
    enum State: String {
        case ready, executing, finished
        var keyPath: String {
            "is\(self.rawValue.capitalized)"
        }
    }
}

class AsyncOperation: Operation {
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    override var isExecuting: Bool {
        state == .executing
    }
    override var isFinished: Bool {
        state == .finished
    }
    override var isAsynchronous: Bool {
        true
    }
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        state = .executing
        main()
    }
    override func cancel() {
        state = .finished
    }
}

class ImageLoadOperation: AsyncOperation {
    let url: URL
    var image: UIImage?
    var task: URLSessionTask?
    init(url: URL) {
        self.url = url
        super.init()
    }
    
    override func main() {
        task = URLSession.shared.dataTask(with: URLRequest(url: url)) {[weak self] data, response, error in
            defer { self?.state = .finished }
            guard let self = self else { return }
            if isCancelled {
//                print("Cancelling Loading of Image")
                return
            }
            if error == nil, let data = data {
                image = UIImage(data: data)
            } else {
//                print(error!.localizedDescription)
            }
            
        }
//        if self.isCancelled {
//            state = .finished
//            return
//        }
        task?.resume()
    }
    override func cancel() {
        super.cancel()
        task?.cancel()
    }
}
