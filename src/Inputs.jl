using CrystallographyBase: Cell
using CrystallographyRecipes
using QuantumESPRESSO.PWscf: PWInput

@userplot CellPlot
@recipe function f(plot::CellPlot)
    input = plot.args[end]
    typeassert(input, PWInput)
    return Cell(input)
end
