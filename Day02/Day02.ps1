$puzzleInput = get-content $PSScriptRoot/input.txt

$maxRed = 12
$maxGreen = 13
$maxBlue = 14

$partOneAnswer = 0 

foreach ($game in $puzzleInput) {
	[int]$gameID = ([regex]::Match($game, '(?<=Game\s)(.[0-9]?)(?=:)')).ToString()

	:gameCheck do {
		$redDraws = [regex]::Matches($game, '(?<=\s)(.[0-9]?)(?=\sred)')
		foreach ($red in $redDraws) {
			if ([int]$red.Value -gt $maxRed) { break gameCheck }
		}
		$greenDraws = [regex]::Matches($game, '(?<=\s)(.[0-9]?)(?=\sgreen)')
		foreach ($green in $greenDraws) {
			if ([int]$green.Value -gt $maxGreen) { break gameCheck }
		}
		$blueDraws = [regex]::Matches($game, '(?<=\s)(.[0-9]?)(?=\sblue)')
		foreach ($blue in $blueDraws) {
			if ([int]$blue.Value -gt $maxBlue) { break gameCheck }
		}
		$partOneAnswer += $gameID
	}while ($false)
}

Write-Host "Part One Answer: $partOneAnswer"

#### PART 2 ####

$partTwoAnswer = 0

foreach ($game in $puzzleInput) {

	$biggestRed = 0
	$biggestGreen = 0
	$biggestBlue = 0

	$redDraws = [regex]::Matches($game, '(?<=\s)(.[0-9]?)(?=\sred)')
	foreach ($red in $redDraws) {
		if ([int]$red.Value -gt $biggestRed) { $biggestRed = [int]$red.Value }
	}

	$greenDraws = [regex]::Matches($game, '(?<=\s)(.[0-9]?)(?=\sgreen)')
	foreach ($green in $greenDraws) {
		if ([int]$green.Value -gt $biggestGreen) { $biggestGreen = [int]$green.Value }
	}

	$blueDraws = [regex]::Matches($game, '(?<=\s)(.[0-9]?)(?=\sblue)')
	foreach ($blue in $blueDraws) {
		if ([int]$blue.Value -gt $biggestBlue) { $biggestBlue = [int]$blue.Value }
	}
	
	$partTwoAnswer += ($biggestRed * $biggestGreen * $biggestBlue)

}

Write-Host "Part Two Answer: $partTwoAnswer"