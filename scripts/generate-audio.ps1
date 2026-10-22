$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Speech

$outputDirectory = Join-Path $PSScriptRoot '..\audio'
$spokenLetters = [ordered]@{
    F = 'ef'
    K = 'ka'
    L = 'el'
    R = 'er'
    S = 'es'
    Z = 'zet'
}

$synth = [System.Speech.Synthesis.SpeechSynthesizer]::new()
try {
    $synth.SelectVoice('Microsoft Paulina Desktop')
    $synth.Rate = 0
    $synth.Volume = 100

    foreach ($letter in $spokenLetters.Keys) {
        $path = Join-Path $outputDirectory "$letter.wav"
        $synth.SetOutputToWaveFile($path)
        $synth.Speak($spokenLetters[$letter])
        $synth.SetOutputToNull()
    }
}
finally {
    $synth.Dispose()
}
