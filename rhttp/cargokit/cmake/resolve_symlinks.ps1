function Resolve-Symlinks {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string] $Path
    )

    $Private:Item = Get-Item -LiteralPath $Path
    if ([string]::IsNullOrEmpty($Private:Item.Target)) {
        $Private:Parent = Resolve-Symlinks $Private:Item.Parent
        return Join-Path $Private:Parent $Private:Item.Name
    }
    else {
        return $Private:Item.Target
    }
}

$path=Resolve-Symlinks -Path $args[0]
Write-Host $path
