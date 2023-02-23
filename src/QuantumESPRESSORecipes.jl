module QuantumESPRESSORecipes

using QuantumESPRESSO.Outputs.PWscf
using RecipesBase: @userplot, @recipe, @series

@userplot DecomposedEnergyPlot
@recipe function f(plot::DecomposedEnergyPlot)
    framestyle --> :box
    legend_foreground_color --> nothing
    grid --> nothing
    seriestype --> :scatter
    xguide --> "steps"
    yguide --> "energy"
    df = first(plot.args)
    steps = df[:, 1]
    xticks --> steps
    columnnames = names(df)
    for (j, column) in enumerate(eachcol(df))
        if j == 1
            continue
        end
        @series begin
            label --> string(columnnames[j])
            column
        end
    end
end

end
