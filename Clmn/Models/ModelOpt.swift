import CoreData

struct ModelOpt<T> : Identifiable {
    let id: UUID = UUID()
    let model: T?

    init(model: T?) {
        self.model = model
    }

    func isNew() -> Bool {
        model == nil
    }
    func isExisting() -> Bool {
        model != nil
    }
    func get() -> T {
        return model!
    }

    static func ofNew<R>() -> ModelOpt<R> {
        ModelOpt<R>(model: nil)
    }
    static func of<R>(_ model: R) -> ModelOpt<R> {
        ModelOpt<R>(model: model)
    }
}
