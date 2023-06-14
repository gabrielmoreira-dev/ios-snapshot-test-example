enum NetworkError: Error {
    case invalidURL
    case server(Error)
    case emptyBody
    case decode(Error)
}
