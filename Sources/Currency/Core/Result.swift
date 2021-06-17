struct LocalError: Error {
    var localizedDescription: String {
        message
    }
    
    var message = ""
}

enum Result<T> {
	case success(T)
	case failure(Error)
}
