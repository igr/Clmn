import CoreData

/// Optional container used for adding/editing model details.
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

    /// Returns true if optional model exists.
    func exists() -> Bool {
        model != nil
    }
}
