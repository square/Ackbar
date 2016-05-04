//
//  DeathStarAssault.swift
//  Endor
//
//  Created by Brian Partridge on 5/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//


class DeathStarAssault {
    
    // MARK: - Properties
    
    internal(set) var hasDeathStarPlans = true
    internal(set) var isTheEmpireAware = false
    private(set) var complete = false
    
    // MARK: - Methods
    
    func run() {
        precondition(hasDeathStarPlans, "Time to sacrifice some Bothans.")
        assert(!isTheEmpireAware, "Sneak attacks only.")
        complete = true
    }
}
