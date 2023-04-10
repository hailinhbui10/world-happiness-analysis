
function Recreate-Conda-Environment($EnvironmentName, $EnvironmentFileName, $PipIniPath = "pip.ini") {
    conda deactivate
    conda env list
    echo "Recreate env name: $EnvironmentName"
    echo "Recreate env file name: $EnvironmentFileName"
    conda remove --name $EnvironmentName --all -y
    conda activate base
    $CondaBase=$env:CONDA_PREFIX
    echo "Conda base $CondaBase"
    conda env create -f $EnvironmentFileName
    conda activate $EnvironmentName
    if (Test-Path $PipIniPath){
        copy $PipIniPath $CondaBase\envs\$EnvironmentName
    } else {
        Write-Host "WARNING: $PipIniPath doesn't exist"
    }

}

function Install-Internal-Libraries ($InternalLibrariesFilePath) {
    $InternalLibraries = convertfrom-stringdata (get-content $InternalLibrariesFilePath -raw)
    echo "Specified internal libraries versions"
    $InternalLibraries

    foreach ($h in $InternalLibraries.GetEnumerator()) {
        pip install "$($h.Name)==$($h.Value)"
    }

}

$EnvironmentName = "my-analysis-env"
$EnvironmentFileName = "$EnvironmentName.yml"

Recreate-Conda-Environment $EnvironmentName $EnvironmentFileName

