import CoreData

struct ModelOpt<T>: Identifiable {
    let id: UUID = UUID()
    let model: T?

    init(model: T?) {
        self.model = model
    }

    static func ofNew<R>() -> ModelOpt<R> {
        ModelOpt<R>(model: nil)
    }

    static func of<R>(_ model: R) -> ModelOpt<R> {
        ModelOpt<R>(model: model)
    }

    func apply(ifEmpty: () -> Void, or ifExisting: (T) -> Void) {
        if (model == nil) {
            ifEmpty()
        } else {
            ifExisting(model!)
        }
    }

    /// Returns true if optional model exists.
    func exists() -> Bool {
        model != nil
    }
}
