$input = get-content $PSScriptRoot/input.txt

$totalPoints = 0

foreach ($card in $input) {
	$card = $card.split(":")[1]
	$winNums = [regex]::Replace(($card.Split('|')[0]), "\s+", " ").trim().split(" ")
	$myNums = [regex]::Replace(($card.Split('|')[1]), "\s+", " ").trim().split(" ")
	$cardPoints = 0

	foreach ($num in $myNums) {
		if ($num -in $winNums) {
			if ($cardPoints -eq 0) { $cardPoints = 1 }
			else { $cardPoints = $cardPoints * 2 }
		}
	}
	$totalPoints += $cardPoints
}

Write-Host "Part One Solution: $totalPoints"