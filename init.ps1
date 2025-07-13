Copy-Item $PSScriptRoot/dotnet.Taskfile.template -Destination (Join-Path -Path $PSScriptRoot -ChildPath "../Taskfile.yml")
