using QuantumESPRESSORecipes
using Documenter

DocMeta.setdocmeta!(QuantumESPRESSORecipes, :DocTestSetup, :(using QuantumESPRESSORecipes); recursive=true)

makedocs(;
    modules=[QuantumESPRESSORecipes],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/MineralsCloud/QuantumESPRESSORecipes.jl/blob/{commit}{path}#{line}",
    sitename="QuantumESPRESSORecipes.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/QuantumESPRESSORecipes.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/QuantumESPRESSORecipes.jl",
    devbranch="main",
)
