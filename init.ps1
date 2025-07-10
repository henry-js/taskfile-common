Copy-Item $PSScriptRoot/Taskfile.yml.template -Destination (Join-Path -Path $PSScriptRoot -ChildPath "../Taskfile.yml")
