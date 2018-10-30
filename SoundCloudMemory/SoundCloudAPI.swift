
import UIKit
import PromiseKit
import Alamofire
import SwiftyJSON

class SoundCloudAPI: NSObject {
    
    private let manager: Alamofire.SessionManager = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders // use default headers
        configuration.timeoutIntervalForRequest = 30 // 30 secs for request timeout
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData // disable http caching
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    // Singleton API Instance
    class var shared: SoundCloudAPI {
        struct Singleton {
            static let instance: SoundCloudAPI = SoundCloudAPI()
        }
        return Singleton.instance
    }
    
    public func getPlaylistTracks() -> Promise<[Track]> {
        return Promise { promise in
            // check network is available
            if NetworkUtil.isNetworkReachable() == false {
                Logger.debug("device is not connected to the Internet")
                promise.reject(AppError.API(.networkUnreachable))
                return
            }
            
            Logger.debug("will send a request to get tracks from soundcloud api")
            // request params
            let parameters = [
                "client_id": Environment.shared.clientId,
                "client_secret": Environment.shared.clientSecret
            ]
            // send the request to soundcloud api
            self.manager.request(Environment.shared.apiBaseUrl, method: .get, parameters: parameters).response { (response) in
                Logger.debug("Request URL : \(response.request?.url?.absoluteString ?? "nil")")
                Logger.debug("Request Method : \(response.request?.httpMethod ?? "nil")")
                Logger.debug("Request Headers : \(String(describing: response.request?.allHTTPHeaderFields))")
                Logger.debug("Request Parameters : \(response.request?.url?.query ?? "nil")")
                Logger.debug("Error : \(String(describing: response.error))")
                
                if let error = response.error{
                    // response has an error
                    promise.reject(error)
                }else{
                    if let data = response.data{
                        let json = JSON(data: data)
                        Logger.debug("JSON Response: \(json)") // serialized json response
                        let tracksArray = json["tracks"].arrayValue // card images under tracks
                        let listOfTracks = tracksArray.compactMap({return Track.init(withJson: $0)}) // convert each json object(track) to a model
                        promise.fulfill(listOfTracks)
                    }else{
                        // if response data is not available
                        promise.reject(AppError.API(.noData))
                    }
                }
            }
        }
    }
    
    public func downloadTrackImage(track: Track) -> Promise<Card> {
        return Promise { promise in
            // check network is available
            if NetworkUtil.isNetworkReachable() == false {
                Logger.debug("device is not connected to the Internet")
                promise.reject(AppError.API(.networkUnreachable))
                return
            }
            
            self.manager.request(track.imageUrl, method: .get).response { (response) in
                if let error = response.error {
                    promise.reject(error)
                }else {
                    if let data = response.data,
                        let image = UIImage(data: data, scale: 1.0){
                        let card = Card(id: track.id, image: image) // we model track id-artwork_url tuple to card for our game
                        promise.fulfill(card)
                    }else{
                        // if response data is not available
                        promise.reject(AppError.API(.cantDownloadImage))
                    }
                }
            }
        }
    }
}
