import Foundation

typealias DownloadImageCompletion = (Result<Data, NetworkError>) -> Void

protocol NetworkManaging {
    func downloadImage(address: String, completion: @escaping DownloadImageCompletion)
}

final class NetworkManager: NetworkManaging {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func downloadImage(address: String, completion: @escaping DownloadImageCompletion) {
        guard let url = URL(string: address) else {
            return completion(.failure(.invalidURL))
        }
        
        session.downloadTask(with: url) { localURL, _, error in
            if let error = error {
                return completion(.failure(.server(error)))
            }
            guard let localURL = localURL else {
                return completion(.failure(.emptyBody))
            }
            do {
                let data = try Data(contentsOf: localURL)
                completion(.success(data))
            } catch {
                completion(.failure(.decode(error)))
            }
        }.resume()
    }
}
