function Resolve-Symlinks {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string] $Path
    )

    $Private:Item = Get-Item -LiteralPath $Path
    if ([string]::IsNullOrEmpty($Private:Item.Target)) {
        return Resolve-Symlinks $Private:Item.Parent
    }
    else {
        return $Private:Item.Target
    }
}

$path=Resolve-Symlinks -Path $args[0]
Write-Host $path
