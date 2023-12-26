$inputFile = get-content $PSScriptRoot/input.txt
$totalPoints = 0

foreach ($card in $inputFile) {
	$card = $card.split(":")[1]
	$winNums = [regex]::Replace(($card.Split('|')[0]), "\s+", " ").trim().split(" ")
	$myNums = [regex]::Replace(($card.Split('|')[1]), "\s+", " ").trim().split(" ")
	$cardPoints = 0

	foreach ($num in $myNums) {
		if ($num -in $winNums) {
			if ($cardPoints -eq 0) { 
				$cardPoints = 1 
			}
			else {
				$cardPoints = $cardPoints * 2
			}
		}
	}
	$totalPoints += $cardPoints
}

Write-Host "Part One Solution: $totalPoints"

#############
# PART 2
#############

$global:totalCards = 0

function checkCard {
	[CmdletBinding()]
	param([int]$cardNumber,[array]$winningNumbers,[array]$myNumbers)

	$matchedNumbers = 0

	foreach ($num in $myNumbers) {
		if ($num -in $winningNumbers) {
			$matchedNumbers++ 
		}
	}
	return $matchedNumbers
}

function addCard {
	[CmdletBinding()]
	param($cardNumber,$tickets)

	$global:totalCards++
	
	if([int]$tickets["$cardNumber"] -ne 0)
	{
		for($i = [int]$cardNumber + 1; $i -le [int]$cardNumber + [int]$tickets["$cardNumber"]; $i++){
			addCard -cardNumber $i -tickets $tickets
		}
	}
	return
}

$ticketList = [ordered]@{}

foreach ($card in $inputFile) {
	$cardNum = ([regex]::Match($card, "\d+")).Value
	$winNums = [regex]::Replace(($card.Split('|')[0]), "\s+", " ").trim().split(" ")
	$myNums = [regex]::Replace(($card.Split('|')[1]), "\s+", " ").trim().split(" ")

	$checkCard = checkCard -cardNumber $cardNum -winningNumbers $winNums -myNumbers $myNums

	$ticketList.Add($cardNum, $checkCard)

}

$ticketList.GetEnumerator() | ForEach-Object {addCard -cardNumber $_.key -tickets $ticketList}

write-host "Part 2 Solution: $global:totalCards"