import CoreData

/// Optional model holder.
struct ModelPairOpt<T, O>: Identifiable {
    let id: UUID = UUID()
    let model: T?
    let owner: O

    init(model: T?, owner: O) {
        self.model = model
        self.owner = owner
    }

    static func ofNew<R, P>(_ owner: P) -> ModelPairOpt<R, P> {
        ModelPairOpt<R, P>(model: nil, owner: owner)
    }

    static func of<R, P>(_ owner: P, _ model: R) -> ModelPairOpt<R, P> {
        ModelPairOpt<R, P>(model: model, owner: owner)
    }

    func apply(ifEmpty: (O) -> Void, or ifExisting: (O, T) -> Void) {
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
}
