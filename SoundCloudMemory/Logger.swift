
import UIKit

struct Logger {
    
    private static let queue = DispatchQueue(label: "soundcloud.memory.logger")
    
    static func debug(_ message : String, path: String = #file, line: Int = #line) {
        log(message, level: NSLocalizedString("log-debug", comment: ""), path: path, line: line)
    }
    
    static func info(_ message : String, path: String = #file, line: Int = #line) {
        log(message, level: NSLocalizedString("log-info", comment: ""), path: path, line: line)
    }
    
    static func verbose(_ message : String, path: String = #file, line: Int = #line) {
        log(message, level: NSLocalizedString("log-verbose", comment: ""), path: path, line: line)
    }
    
    static func warning(_ message : String, path: String = #file, line: Int = #line) {
        log(message, level: NSLocalizedString("log-warning", comment: ""), path: path, line: line)
    }
    
    static func error(_ message : String, path: String = #file, line: Int = #line) {
        log(message, level: NSLocalizedString("log-error", comment: ""), path: path, line: line)
    }
    
    private static func log(_ message:String, level:String, path:String, line:Int){
        if Environment.shared.debug{
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            let file = path.components(separatedBy: "/").last!
            
            queue.async {
                print("[\(dateFormatter.string(from: date))] \(file):\(line) \(level) - \(message)", separator: "", terminator: "\n")
            }
        }
    }
}
