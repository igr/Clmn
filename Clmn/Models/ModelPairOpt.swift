import CoreData

/// Optional model holder.
struct ModelPairOpt<O, T>: Identifiable {
    let id: UUID = UUID()
    let model: T?
    let owner: O

    init(owner: O, model: T?) {
        self.model = model
        self.owner = owner
    }

    static func ofNew<A, B>(_ owner: A) -> ModelPairOpt<A, B> {
        ModelPairOpt<A, B>(owner: owner, model: nil)
    }

    static func of<A, B>(_ owner: A, _ model: B) -> ModelPairOpt<A, B> {
        ModelPairOpt<A, B>(owner: owner, model: model)
    }

    func new(ifEmpty: (O) -> Void, existing ifExisting: (O, T) -> Void) {
        if (model == nil) {
            ifEmpty(owner)
        } else {
            ifExisting(owner, model!)
        }
    }

    /// Returns true if optional model exists.
    func exists() -> Bool {
        model != nil
    }

    func just() -> ModelOpt<T> {
        ModelOpt<T>(model: model)
    }
}
