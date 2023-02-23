module QuantumESPRESSORecipes

using DataFrames: groupby
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

@userplot ElectronsEnergyPlot
@recipe function f(plot::ElectronsEnergyPlot)
    framestyle --> :box
    legend_foreground_color --> nothing
    grid --> nothing
    seriestype --> :scatter
    xguide --> "iterations"
    yguide --> "energy"
    df = first(plot.args)
    columnnames = names(df)
    for (i, subdf) in enumerate(groupby(df, :step))
        for (j, column) in enumerate(eachcol(subdf))
            if j in (1, 2)
                continue
            end
            @series begin
                label --> string(columnnames[j], " (iteration ", i, ')')
                filter(!isnothing, column)
            end
        end
    end
end

@userplot IterationTimePlot
@recipe function f(plot::IterationTimePlot)
    framestyle --> :box
    legend_foreground_color --> nothing
    grid --> nothing
    seriestype --> :scatter
    xguide --> "iteration"
    yguide --> "time"
    df = first(plot.args)
    for (i, subdf) in enumerate(groupby(df, :step))
        @series begin
            label --> string("iteration ", i)
            subdf.iteration, subdf.time
        end
    end
end

@userplot PressurePlot
@recipe function f(plot::PressurePlot)
    framestyle --> :box
    legend_foreground_color --> nothing
    grid --> nothing
    seriestype --> :scatter
    xguide --> "step"
    yguide --> "pressure"
    label --> ""
    data = first(plot.args)
    steps = eachindex(data)
    xticks --> steps
    return steps, data
end

end
