/// Upgrades data structure.
func upgradeData(from: Int, to: Int) {
    if (from == to) {
        return
    }
    var current = from
    while (current < to) {
        switch current {
        case 0: upgradeV0_V1()
        default: print("Upgrade done.")
        }
        current += 1
    }
    
}

private func upgradeV0_V1() {
    // nothing to do
}
