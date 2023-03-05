using CrystallographyBase: Cell
using CrystallographyRecipes
using QuantumESPRESSO.Inputs.PWscf: PWInput

@userplot CellPlot
@recipe function f(plot::CellPlot)
    input = plot.args[end]
    typeassert(input, PWInput)
    return Cell(input)
end
