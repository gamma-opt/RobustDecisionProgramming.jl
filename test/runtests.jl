using Test
using Logging
using RobustDecisionProgramming

function test_cross_assignment()
    @test isapprox(cross_assignment([1.0], 0.1), [0.0])

    p = [0.4, 0.6]
    d⁻ = [-0.2, -0.2]
    d⁺ = [0.2, 0.2]

    @test isapprox(cross_assignment(p, 0.1), [-0.1, 0.1])
    @test isapprox(cross_assignment(p, d⁻, d⁺), [-0.2, 0.2])
    @test isapprox(cross_assignment(p, d⁻, d⁺, 0.1), [-0.1, 0.1])

    p = [0.1, 0.7, 0.2]
    d⁻ = [-0.1, -0.1, -0.2]
    d⁺ = [0.2, 0.2, 0.05]

    @test isapprox(cross_assignment(p, 0.15), [-0.1, -0.05, 0.15])
    @test isapprox(cross_assignment(p, d⁻, d⁺), [-0.1, 0.05, 0.05])
    @test isapprox(cross_assignment(p, d⁻, d⁺, 0.08), [-0.08, 0.03, 0.05])

    p = [0.1, 0.3, 0.6]
    @test isapprox(cross_assignment(p, 0.0), [0.0, 0.0, 0.0])

    p = [1.0, 0.0]
    @test isapprox(cross_assignment(p, 1.0), [-1.0, 1.0])
end

test_cross_assignment()
