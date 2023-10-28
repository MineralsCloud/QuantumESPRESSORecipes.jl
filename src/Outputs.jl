using DataFrames: groupby
using QuantumESPRESSO.PWscf

@userplot EnergyConvergenceIterationPlot
@recipe function f(plot::EnergyConvergenceIterationPlot)
    framestyle --> :box
    legend_foreground_color --> nothing
    grid --> nothing
    legend_position --> :top
    xguide --> "total number of iterations"
    yguide --> "energy"
    vectors = first(plot.args)
    xlims --> (1, cumsum(length.(vectors))[end])
    total_iterations = 0
    for (i, vector) in enumerate(vectors)
        last_total = total_iterations
        total_iterations += length(vector)
        @series begin
            label --> "SCF step $i"
            seriestype --> :scatter
            markersize --> 2
            markerstrokewidth --> 0
            (last_total + 1):total_iterations, vector
        end
        @series begin
            seriestype --> :vline
            linestyle --> :dot
            seriescolor := :black  # Fix the axis color
            linewidth := 1  # This is an axis, don't change its width
            z_order --> :back
            label := ""
            [total_iterations]
        end
    end
end

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
